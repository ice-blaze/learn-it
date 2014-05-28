class CreateTutorialCommentVotes < ActiveRecord::Migration
  def change
    create_table :tutorial_comment_votes do |t|

      t.timestamps
    end
  end
end
