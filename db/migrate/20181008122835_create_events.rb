class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :color
      t.references :user
      t.timestamps null: false
    end

    add_column :schedules, :event_id, :integer, after: :state, default: nil

  end
end
