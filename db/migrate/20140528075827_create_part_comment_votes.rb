class CreatePartCommentVotes < ActiveRecord::Migration
  def change
    create_table :part_comment_votes do |t|

      t.timestamps
    end
  end
end
