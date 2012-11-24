class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, null: false
      t.references :problem, null: false

      t.string :remote_ip, limit: 128, null: false
      # TODO(pwnall): add limit: 1.megabyte when Rails 3.2.10 comes out
      t.text :code, null: false

      t.timestamp :created_at, null: false
    end
    add_index :submissions, [:user_id, :problem_id, :created_at], null: false,
        unique: true
    add_index :submissions, [:problem_id, :created_at], null: false,
        unique: false
  end
end
