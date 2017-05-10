Rails.application.routes.draw do

  mount GitlabReviewable::Engine => "/reviewable"
end
