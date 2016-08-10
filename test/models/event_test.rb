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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
