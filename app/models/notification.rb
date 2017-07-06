# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_type  :string
#  item_id    :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notifications_on_item_type_and_item_id  (item_type,item_id)
#  index_notifications_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true

  after_commit { NotificationBroadcastJob.perform_later(self) }

  scope :unviewed, -> { where(viewed: false) }
  scope :latest, -> { order(created_at: :desc).limit(10) }

  def self.for_user(user_id)
    where(user_id: user_id).unviewed.count
  end
end
