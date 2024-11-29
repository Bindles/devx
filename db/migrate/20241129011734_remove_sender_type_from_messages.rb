class RemoveSenderTypeFromMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :sender_type, :string
  end
end
