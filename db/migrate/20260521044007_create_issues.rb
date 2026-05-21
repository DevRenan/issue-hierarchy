class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :node, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
