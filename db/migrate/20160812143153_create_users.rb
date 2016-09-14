class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :fname
      t.string :lname
      t.integer :messages_remaining, default: 3
      t.integer :messages_received_count, default: 0
      t.integer :messages_sent_count, default: 0
      t.timestamps
    end
  end
end
