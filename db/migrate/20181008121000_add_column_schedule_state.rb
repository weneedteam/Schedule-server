class AddColumnScheduleState < ActiveRecord::Migration
  def change
    add_column :schedules, :state, :integer, after: :title, default: false
  end
end
