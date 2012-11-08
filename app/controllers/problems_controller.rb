class ProblemsController < ApplicationController

  def index
  end

  def single
    @problem = Problem.where(:id => params[:problem_id]).first
  end

end