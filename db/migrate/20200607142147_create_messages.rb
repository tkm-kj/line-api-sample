class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.bigint :sendable_id, null: false
      t.string :sendable_type, null: false
      t.bigint :receivable_id, null: false
      t.string :receivable_type, null: false
      t.text :text

      t.timestamps
    end
  end
end
