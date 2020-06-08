class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :line_user_id, null: false

      t.timestamps
    end
  end
end
