class Vote < ActiveRecord::Base

  # NOTE: Votes belong to a user
  belongs_to :user
  belongs_to :voteable, :polymorphic => true 
  def self.find_votes_cast_by_user(user)
    find(:all,
      :conditions => ["user_id = ?", user.id],
      :order => "created_at DESC"
    )
  end
end