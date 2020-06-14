class CreateMessageTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :message_texts do |t|
      t.text :content

      t.timestamps
    end
  end
end
