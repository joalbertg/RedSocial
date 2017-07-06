# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  include Notificable

  belongs_to :user
  scope :nuevos, -> { order('created_at desc') }

  after_create :send_to_action_cable

  def self.all_for_user(user)
    where(user_id: user.id).or(where(user_id: user.friend_ids))
                           .or(where(user_id: user.user_ids))
  end

  def user_ids
    user.friend_ids + user.user_ids
  end

  private

  def send_to_action_cable
    data = { message: to_html, action: 'new_post' }

    self.user.friend_ids.each do |friend_id|
      ActionCable.server.broadcast "posts_#{friend_id}", data
    end

    self.user.user_ids.each do |friend_id|
      ActionCable.server.broadcast "posts_#{friend_id}", data
    end
  end

  def to_html
    ApplicationController.renderer.render(partial: 'posts/post',
                                          locals: { post: self })
  end
end
