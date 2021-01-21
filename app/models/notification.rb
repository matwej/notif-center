class Notification < ApplicationRecord
  belongs_to :user
  scope :touch_all, -> { update_all(updated_at: Time.current) }
end
