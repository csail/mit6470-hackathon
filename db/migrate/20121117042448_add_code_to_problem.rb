class AddCodeToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :code, :text
    add_column :problems, :supplement, :text
  end
end
