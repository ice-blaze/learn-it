class CreateInterpreterCommentVotes < ActiveRecord::Migration
  def change
    create_table :interpreter_comment_votes do |t|

      t.timestamps
    end
  end
end
