class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :sender, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
