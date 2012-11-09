class ProblemsController < ApplicationController

  def index
  end

  def single
    @problem = Problem.where(:id => params[:problem_id]).first
  end

  def submit_solution
    soln = Solution.new(:submission => params[:solution],
                        :user_id => session[:current_user_id],
                        :problem_id => params[:problem_id]
                        )
    soln.save!
    return redirect_to :back
  end

end