# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_friend_id_and_user_id  (friend_id,user_id) UNIQUE
#  index_friendships_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#

class Friendship < ApplicationRecord
  include Notificable
  include AASM

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: 'Amistad duplicada.' }

  aasm column: 'status' do
    state :pending, initial: true
    state :active
    state :denied

    event :accepted do
      transitions from: [:pending], to: [:active]
    end

    event :rejected do
      transitions from: [:pending, :active], to: [:denied]
    end
  end

  def self.friends?(user, friend)
    return true if user == friend
    where(user: user, friend: friend).or(
      where(user: friend, friend: user)
    ).any?
  end

  def self.pending_for_user(user)
    pending.where(friend: user)
  end

  def self.accepted_for_user(user)
    active.where(friend: user)
  end

  def user_ids
    user.friend_ids + user.user_ids
  end
end
