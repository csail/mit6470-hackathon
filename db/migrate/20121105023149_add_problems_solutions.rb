class AddProblemsSolutions < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :category
      t.text :description
      t.timestamps
    end

    create_table :solutions do |t|
      t.integer :user_id
      t.integer :problem_id
      t.text :submission
      t.timestamps
    end
  end
end
