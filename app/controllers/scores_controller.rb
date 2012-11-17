class ScoresController < ApplicationController
  before_filter :require_login

  def index
    bounce_user unless current_user.admin?

    @users = User.all.reject! { |user| user.admin? }

    @problems = Problem.order(:name).all
    problem_submissions = {}

    @scores = {}
    @submissions = {}
    @users.each do |user|
      @submissions[user] = {}
      last_accepted_time = 0
      @problems.each do |problem|
        submission = Submission.for_problem(problem).for_user(user).
                                recent_first.first
        if submission
          problem_submissions[problem] = (problem_submissions[problem] || 0) + 1
          @submissions[user][problem] = submission
          if submission.accepted?
            if last_accepted_time.to_f < submission.created_at.to_f
              last_accepted_time = submission.created_at
            end
          end
        end
      end
      score_sum = @submissions[user].values.map(&:score).sum
      @scores[user] = [ -score_sum, last_accepted_time ]
    end

    @problems.reject! { |p| (problem_submissions[p] || 0) == 0 }

    @users.sort_by! { |user| @scores[user] }
  end
end
