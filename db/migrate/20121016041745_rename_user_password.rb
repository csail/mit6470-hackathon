class RenameUserPassword < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.rename :password, :hashed_password
    end
  end
end
