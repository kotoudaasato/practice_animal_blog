module Public::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.post_comment_id
    case notification.action
     when "follow" then
        tag.a(notification.visitor.name, href: user_path(@visitor),style: "font-weight:bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visitor.name, href: user_path(@visitor),style: "font-weight:bold;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id),style: "font-weight:bold;")+"にいいねしました"
      when "comment" then
        @comment = PostComment.find_by(id: @visitor_comment)
        tag.a(@visitor.name, href: user_path(@visitor),style: "font-weight:bold;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id),style: "font-weight:bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
