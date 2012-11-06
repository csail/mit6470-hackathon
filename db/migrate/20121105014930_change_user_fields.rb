class ChangeUserFields < ActiveRecord::Migration
  def change
    remove_column :users, :region
  end

end
