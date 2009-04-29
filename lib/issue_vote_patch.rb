require 'vote'
require 'acts_as_voteable'

Issue.class_eval do
  acts_as_voteable
end