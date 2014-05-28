class AddReferencesToVotes < ActiveRecord::Migration
  def change
    add_reference :tutorial_comment_votes, :user, index: true
    add_reference :tutorial_comment_votes, :tutorial_comment, index: true

    add_reference :part_comment_votes, :user, index: true
    add_reference :part_comment_votes, :part_comment, index: true

    add_reference :interpreter_comment_votes, :user, index: true
    add_reference :interpreter_comment_votes, :interpreter_comment, index: true

    add_reference :function_comment_votes, :user, index: true
    add_reference :function_comment_votes, :function_comment, index: true
  end
end
