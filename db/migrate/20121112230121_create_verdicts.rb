class CreateVerdicts < ActiveRecord::Migration
  def change
    create_table :verdicts do |t|
      t.references :submission, null: false
      t.decimal :score, null: false
      t.decimal :max_score, null: false

      # TODO (pwnall): add limit: 2.kilobytes when rails 3.2.10 comes out
      t.text :message, null: false

      # TODO (pwnall): add limit: 1.megabyte when rails 3.2.10 comes out
      t.text :response_html, null: false

      t.timestamp :created_at, null: false
    end
    add_index :verdicts, :submission_id, null: false, unique: true
  end
end
