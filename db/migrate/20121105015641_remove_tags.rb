class RemoveTags < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :tag_connections
  end
end
