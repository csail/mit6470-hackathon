class RenameUserHashedPassword < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.rename :hashed_password, :password
    end
  end
end
