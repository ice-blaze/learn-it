class AddPositiveToVotes < ActiveRecord::Migration
  def change
    add_column :tutorial_comment_votes, :positive, :boolean
    add_column :part_comment_votes, :positive, :boolean
    add_column :interpreter_comment_votes, :positive, :boolean
    add_column :function_comment_votes, :positive, :boolean
  end
end
