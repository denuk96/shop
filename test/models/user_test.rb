# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  admin            :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
