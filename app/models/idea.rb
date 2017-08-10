class Idea < ApplicationRecord
  has_many :children, class_name: "Idea", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Idea", required: false
end
