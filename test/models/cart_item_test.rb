# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  cart_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  quantity   :integer          default(1)
#  price      :decimal(, )
#  order_id   :bigint
#

require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
