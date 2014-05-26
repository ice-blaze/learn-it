class CreateCommentTutorials < ActiveRecord::Migration
  def change
    create_table :comment_tutorials do |t|
      t.text :content
      t.integer :like
      t.integer :dislike
      t.datetime :date

      t.references :tutorial, index: true

      t.timestamps
    end
  end
end
