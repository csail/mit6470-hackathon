class CreateVerdicts < ActiveRecord::Migration
  def change
    create_table :verdicts do |t|
      t.references :submission, null: false
      t.decimal :score, null: false
      t.decimal :max_score, null: false
      t.text :message, null: false

      t.timestamp :created_at, null: false
    end
    add_index :verdicts, :submission_id, null: false, unique: true
  end
end
