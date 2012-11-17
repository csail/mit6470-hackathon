require 'json'

class SubmissionsController < ApplicationController
  before_filter :require_login

  def index
    @problems = Problem.all.select { |p| p.visible_to? current_user }
    @submissions = Submission.for_user(current_user).recent_first
  end

  def new
    problem = Problem.find params[:problem_id]
    bounce unless problem.visible_to?(current_user)

    @submission = Submission.new problem: problem
    @submission.user = current_user
  end

  def create
    @submission = Submission.new params[:submission]
    bounce unless @submission.problem.visible_to?(current_user)

    @submission.user = current_user
    @submission.remote_ip = request.remote_ip

    respond_to do |format|
      if @submission.save
        format.html { redirect_to submissions_url }
      else
        format.html { render action: :new }
      end
    end
  end
end
