class AddNameToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :name, :string
  end
end
