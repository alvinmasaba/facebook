module UserLikeable
  extend ActiveSupport::Concern

  def likers
    self.user_likers.limit(4)
                    .map { |user| user.full_name }
                    .join(", ")
  end
end