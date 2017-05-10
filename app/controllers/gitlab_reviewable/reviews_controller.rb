module GitlabReviewable
  class ReviewsController < ApplicationController
    include DiffHelper

    skip_before_action :authenticate_user!
    before_action :merge_request
    before_action :define_show_vars
    layout 'review'

    def diffs
      puts 111111
      @note_counts = Note.where(commit_id: @merge_request.commits.map(&:id)).
        group(:commit_id).count

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
      @project = Project.find_by!(id: params[:project_id])
      @merge_request ||= @project.merge_requests.find_by!(iid: params[:merge_request_id])
    end
    
    def define_show_vars
      # Build a note object for comment form
      @note = @project.notes.new(noteable: @merge_request)
      @notes = @merge_request.mr_and_commit_notes.nonawards.inc_author.fresh
      @discussions = @notes.discussions
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
  end
end