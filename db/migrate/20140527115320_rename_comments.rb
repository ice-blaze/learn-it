class RenameComments < ActiveRecord::Migration
  def change
    rename_table :comment_functions, :function_comments
    rename_table :comment_interpreters, :interpreter_comments
    rename_table :comment_tutorials, :tutorial_comments
    rename_table :comment_parts, :part_comments
  end
end
