class Issue < ApplicationRecord
  belongs_to :workspace
  belongs_to :node

  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many_attached :files

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
  validate :acceptable_files

  scope :by_node, ->(node_ids) {
    where(node_id: node_ids) if node_ids.present?
  }
  scope :by_date_range, ->(start_date, end_date) {
    scope = all
    scope = scope.where('created_at >= ?', start_date) if start_date.present?
    scope = scope.where('created_at <= ?', end_date) if end_date.present?
    scope
  }
  scope :ordered_by_priority, -> {
    order(Arel.sql("CASE priority
      WHEN 3 THEN 0
      WHEN 2 THEN 1
      WHEN 1 THEN 2
      WHEN 0 THEN 3
      END, created_at DESC"))
  }

  def acceptable_files
    return unless files.attached?
    files.each do |file|
      unless file.byte_size <= 10.megabytes
        errors.add(:files, "is too big. Each file should be less than 10MB")
      end
      acceptable_types = ["image/jpeg", "image/png", "image/gif", "application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
      unless acceptable_types.include?(file.content_type)
        errors.add(:files, "must be a JPG, PNG, GIF, PDF, or DOC/DOCX")
      end
    end
  end
end