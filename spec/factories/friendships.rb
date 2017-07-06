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

FactoryGirl.define do
  factory :friendship do
    association :user, factory: :user
    association :friend, factory: :user
    status "MyString"
  end
end
