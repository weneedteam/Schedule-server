class CreateScheduleUsers < ActiveRecord::Migration
  def change
    create_table :schedule_users do |t|
      t.integer :schedule_id
      t.integer :user_id
      t.boolean :arrive
      t.datetime :arrived_at

      t.timestamps null: false
    end
  end
end
