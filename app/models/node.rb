class Node < ApplicationRecord
  # Retorna todos os ids descendentes (incluindo o próprio)
  def self.self_and_descendant_ids(node_id)
    node = find_by(id: node_id)
    return [node_id] unless node
    [node.id] + node.descendant_ids
  end
  has_ancestry

  belongs_to :workspace
  has_many :issues, dependent: :destroy

  validates :name, presence: true
  validates :node_type, presence: true
end