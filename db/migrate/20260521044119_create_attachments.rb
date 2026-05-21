class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.references :issue, null: false, foreign_key: true
      t.string :name
      t.string :file_path

      t.timestamps
    end
  end
end
