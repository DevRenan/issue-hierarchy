class Workspace < ApplicationRecord
  has_many :nodes, dependent: :destroy

  validates :name, presence: true
end