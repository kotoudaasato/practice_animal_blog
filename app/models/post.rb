class Post < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  #いいね
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #通知
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

  #タグ
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

     old_tags.each do |old|
      tag_id = Tag.find_by(name: old).id
      self.post_tags.find_by(tag_id: tag_id).destroy
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end


end
