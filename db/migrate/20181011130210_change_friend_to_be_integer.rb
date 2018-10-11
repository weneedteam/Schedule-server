class ChangeFriendToBeInteger < ActiveRecord::Migration
  def change
    change_column :friends, :assent, :integer, default: 0
  end
end
