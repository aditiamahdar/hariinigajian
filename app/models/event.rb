# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  event_id    :string(255)
#  name        :string(255)
#  description :text(65535)
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  validates :name, :price, presence: true
  validates :event_id, uniqueness: true, presence: true
end
