class CreateEndpoints < ActiveRecord::Migration
  def change
    create_table :endpoints do |t|
      t.string :name, limit: 128, null: false
      t.string :url, limit: 256, null: false
    end
    add_index :endpoints, :name, unique: true, null: false
    add_index :endpoints, :url, unique: true, null: false
  end
end
