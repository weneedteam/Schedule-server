class AddFcmTokenUser < ActiveRecord::Migration
  def change
    add_column :users, :fcm_token, :string, after: :auth_token
  end
end
