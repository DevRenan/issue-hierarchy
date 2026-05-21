class CreateNodes < ActiveRecord::Migration[8.1]
  def change
    create_table :nodes do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :node_type
      t.string :ancestry

      t.timestamps
    end
  end
end
