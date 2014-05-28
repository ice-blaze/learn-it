class CreateFunctionCommentVotes < ActiveRecord::Migration
  def change
    create_table :function_comment_votes do |t|

      t.timestamps
    end
  end
end
