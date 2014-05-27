class RemoveDateComments < ActiveRecord::Migration
  def change
    remove_column :interpreter_comments, :date
    remove_column :function_comments, :date
    remove_column :tutorial_comments, :date
    remove_column :part_comments, :date
  end
end
