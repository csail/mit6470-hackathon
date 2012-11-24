class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.references :category, null: false
      t.references :endpoint, null: false
      t.string :name, length: 128, null: false
      t.string :task_name, length: 32, null: false
      t.boolean :published, null: false, default: false
      t.integer :weight, null: false, default: 1
      # TODO(pwnall): add limit: 16.kilobytes when Rails 3.2.10 comes out
      t.text :starter_code, null: false
      # TODO(pwnall): add limit: 1.megabyte when Rails 3.2.10 comes out
      t.text :description_html, null: false
    end
    add_index :problems, :name, unique: true, null: false
    add_index :problems, :task_name, unique: true, null: false
  end
end

