class VerdictsController < ApplicationController
  before_filter :require_login

  # GET /verdicts/1
  def show
    @verdict = Verdict.find params[:id]
    unless current_user.admin? or @verdict.submission.user == current_user
      bounce_user
    end
  end

  # GET /verdicts/1/endpoint_response
  def endpoint_response
    @verdict = Verdict.find params[:id]
    unless current_user.admin? or @verdict.submission.user == current_user
      bounce_user
    end

    render text: @verdict.response_html
  end
end
