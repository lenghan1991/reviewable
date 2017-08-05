module GitlabReviewable
  class ReviewsController < ApplicationController
    include DiffHelper

    skip_before_action :authenticate_user!
    before_action :merge_request
    before_action :define_show_vars
    layout 'review'

    def diffs
      # @note_counts = Note.where(commit_id: @merge_request.commits.map(&:id)).
      #   group(:commit_id).count
      
      respond_to do |format|
        format.html
      end
    end

    def discussion 
      @note_counts = Note.where(commit_id: @merge_request.commits.map(&:id)).
        group(:commit_id).count

      respond_to do |format|
        format.html
      end
    end

    private

    def merge_request
      @project = Project.find_by!(id: params[:m_project_id])
      @merge_request ||= @project.merge_requests.find_by!(iid: params[:m_merge_request_id])
    end
    
    def define_show_vars
      # Build a note object for comment form
      @note = @project.notes.new(noteable: @merge_request)
      @discussions = @notes.discussions
      @notes = prepare_notes_for_rendering(@discussions.flat_map(&:notes))
      @noteable = @merge_request

      # Get commits from repository
      # or from cache if already merged
      @commits = @merge_request.commits

      @merge_request_diff = @merge_request.merge_request_diff

      @ci_commit = @merge_request.ci_commit
      @statuses = @ci_commit.statuses if @ci_commit

      if @merge_request.locked_long_ago?
        @merge_request.unlock_mr
        @merge_request.close
      end
    end
    
    def prepare_notes_for_rendering(notes)
      preload_noteable_for_regular_notes(notes)
      preload_max_access_for_authors(notes, @project)
      Banzai::NoteRenderer.render(notes, @project, current_user)

      notes
    end

    def preload_max_access_for_authors(notes, project)
      return nil unless project

      user_ids = notes.map(&:author_id)
      project.team.max_member_access_for_user_ids(user_ids)
    end

    def preload_noteable_for_regular_notes(notes)
      ActiveRecord::Associations::Preloader.new.preload(notes.reject(&:for_commit?), :noteable)
    end
  end
end