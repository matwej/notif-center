class NotificationDto
  attr_reader :title, :description, :seen, :created_at, :client

  def initialize(notification, current_user)
    @created_at = notification.created_at.strftime("%d.%m.%Y")
    @title = notification.title
    @description = notification.description
    @seen = notification.updated_at != notification.created_at
    @client = notification.user.name if current_user.is_admin?
  end
end