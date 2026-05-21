class Node < ApplicationRecord
  has_ancestry

  belongs_to :workspace
  has_many :issues, dependent: :destroy

  validates :name, presence: true
  validates :node_type, presence: true
end