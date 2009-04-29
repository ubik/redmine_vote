require 'redmine'
require_dependency 'issues_controller' 

class IssuesController < ApplicationController
  skip_before_filter :authorize, :only => [:vote]
  #before_filter :find_issue, :only => [:vote] #[:show, :edit, :reply]
  #before_filter :authorize, :only => [:vote] #:except => [:index, :changes, :gantt, :calendar, :preview, :update_form, :context_menu]
  def vote
    find_issue
    authorize
    @issue.vote(params[:vote] == "up" ? :up : :down)
    @issue.save
    redirect_to :controller => 'issues', :action => 'show', :id => @issue
  end
end  