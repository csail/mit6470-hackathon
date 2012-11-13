class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.references :category, null: false
      t.references :endpoint, null: false
      t.string :name, length: 128, null: false
      t.string :task_name, length: 32, null: false
    end
    add_index :problems, :name, unique: true, null: false
    add_index :problems, :task_name, unique: true, null: false
  end
end
