class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  attr_accessible :body, :rating, :commentable, :user_id
  validates :body, :presence => true
  validates :user, :presence => true
  validates :rating, presence: true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_votable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user

  # callbacks to add rating and rating count to business model in case of rating or rating count change
  after_save :update_commentable_rating_avg_and_count if :rating_changed? || :rating_count_changed?
  #callback to update count after comment is removed
  before_destroy :update_commentable_rating_avg_and_count

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, rating, comment)
    new \
      :commentable => obj,
      :body        => comment,
      :user_id     => user_id,
      rating: rating
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user and ordered by rating.
  scope :find_best_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('rating DESC')
  }

  scope :find_worst_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('rating ASC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  scope :find_best_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('rating DESC')
  }

  scope :find_worst_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('rating ASC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  private
  #method to update rating and rating comment in the Business Model.
  def update_commentable_rating_avg_and_count
    rating = commentable.comment_threads.average("rating").to_f
    rating_count = commentable.comment_threads.count
    commentable.update_attributes(rating: rating, rating_count: rating_count)
  end
end
