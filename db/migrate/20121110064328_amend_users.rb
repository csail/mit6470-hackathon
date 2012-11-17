class AmendUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :admin, null: false, default: false
      t.string :team_name, limit: 64, null: false
    end
    add_index :users, :team_name, null: false, unique: true
  end
end
