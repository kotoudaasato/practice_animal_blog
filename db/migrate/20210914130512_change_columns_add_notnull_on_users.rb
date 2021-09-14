class ChangeColumnsAddNotnullOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :profile_image, :string, null: false
    change_column :users, :is_deleted, :boolean, null: false, default: false
  end
end
