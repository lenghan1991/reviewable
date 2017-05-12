# Gitlab(v8.8.3) Reviewable

Add two seperate pages in gitlab merge request for reviewing tools.

## Usage
in Gemfile

```ruby
gem 'gitlab_reviewable'
```

in  routes.rb

```ruby
mount GitlabReviewable::Engine, at: "/reviews"
```

## Result
add two new pages

```
visit /reviews/diffs?m_project_id=XXX&m_merge_request_id=XXX
visit /reviews/discussion?m_project_id=XXX&m_merge_request_id=XXX
```
