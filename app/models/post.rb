class Post < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 500}
  
  default_scope -> { order(created_at: :desc) }
  #means that when we call User.all, it will display in a descending order, from the last to the first.
                                                    #from the biggest index number to the smallest.
end
