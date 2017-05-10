$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reviewable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gitlab_reviewable"
  s.version     = Reviewable::VERSION
  s.authors     = ["lenghan"]
  s.email       = ["lenghan1991@gmail.com"]
  s.homepage    = "http://github.com/lenghan1991/reviewable"
  s.summary     = "review page via the merge request"
  s.description = "Two new page for review."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"
  s.add_dependency "haml-rails", '~> 0.9.0'

end
