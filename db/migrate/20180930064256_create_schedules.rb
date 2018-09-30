class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title
      t.datetime :start_time
      t.float :latitude, :limit => 50
      t.float :longitude, :limit => 50
      t.text :content
      t.references :user
      t.timestamps null: false
    end
  end
end
