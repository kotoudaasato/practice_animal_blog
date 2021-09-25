class Post < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "favorite"
      )
    notification.save
  end

  def create_notification_comment!(current_user,post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
    post_id: id,
    post_comment_id: post_comment_id,
    visited_id: visited_id,
    action: 'comment')
    if notification.visitor_id == notification.visited_id
      notification.checked == true
    end
    notification.save
  end


end
