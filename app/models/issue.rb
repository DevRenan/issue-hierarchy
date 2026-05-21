class Issue < ApplicationRecord
  belongs_to :workspace
  belongs_to :node

  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy

  enum :status, {
    open: 0,
    in_progress: 1,
    resolved: 2,
    closed: 3
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }

  validates :title, presence: true
end