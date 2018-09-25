class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :request_user_id
      t.integer :response_user_id
      t.boolean :assent
      t.datetime :assented_at

      t.timestamps null: false
    end
  end
end
