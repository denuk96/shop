# == Schema Information
#
# Table name: product_categories
#
#  id          :bigint           not null, primary key
#  product_id  :bigint
#  category_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category
end