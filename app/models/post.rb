class Post < ActiveRecord::Base
  has_many :comments, as: :commentable
  belongs_to :user


  default_scope -> { order('created_at DESC') }
  
  def post
    commentable.is_a?(Post) ? commentable : commentable.post
  end
end
