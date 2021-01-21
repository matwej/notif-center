class NotificationsController < ApplicationController
  before_action :admin_authorization, only: [:create]

  # GET /notifications
  def index
    if current_user.is_admin?
      render json: Notification.all.map{ |n| ::NotificationDto.new(n, current_user) }
    else
      @notifications = Notification.where(user_id: current_user.id)
      @notifications.touch_all # indicate that notification was seen
      render json: @notifications.map{ |n| ::NotificationDto.new(n, current_user) }
    end
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: @notification, status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  private

    def admin_authorization
      render json: {auth: 'Operation not permitted!'}, status: 403 unless current_user.is_admin?
    end

    def notification_params
      params.require(:notification).permit(:title, :description, :user_id)
    end
end
