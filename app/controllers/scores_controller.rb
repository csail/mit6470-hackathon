class ScoresController < ApplicationController
  before_filter :require_login

  def index
    @users = User.all.reject! { |user| user.admin? }

    @problems = Problem.order(:name).all.
                        select { |p| p.visible_to? current_user }

    @scores = {}
    @submissions = {}
    @users.each do |user|
      @submissions[user] = {}
      last_accepted_time = 0
      @problems.each do |problem|
        submission = Submission.for_problem(problem).for_user(user).
                                recent_first.first
        if submission
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

    @users.sort_by! { |user| @scores[user] }
  end
end
