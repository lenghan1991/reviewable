# Gitlab Reviewable

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
