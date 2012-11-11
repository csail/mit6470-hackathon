class ProblemsController < ApplicationController
  before_filter :require_login, :only => [:submit_solution]
  before_filter :require_admin, :only => [:create]

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

  def submit_problem
    prob = Problem.new(:name => params[:name],
                       :category => params[:problem]['category'],
                       :description => params[:description]
                       )
    prob.save!
    return redirect_to :controller => "home", :action => "index"
  end

end