class RenameUserZip < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.rename :zip, :region
    end
  end
end
