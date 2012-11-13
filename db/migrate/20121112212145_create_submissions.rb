class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, null: false
      t.references :problem, null: false

      t.string :remote_ip, limit: 128, null: false
      t.text :code, null: false
      # TODO(pwnall): fix rails bug -- pgsql doesn't allow limit: on text
      # t.text :code, limit: 1.megabyte, null: false

      t.timestamp :created_at, null: false
    end
    add_index :submissions, [:user_id, :problem_id, :created_at], null: false,
        unique: true
    add_index :submissions, [:problem_id, :created_at], null: false,
        unique: false
  end
end
