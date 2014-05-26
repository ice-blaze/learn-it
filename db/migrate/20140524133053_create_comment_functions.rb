class CreateCommentFunctions < ActiveRecord::Migration
  def change
    create_table :comment_functions do |t|
      t.text :content
      t.integer :like
      t.integer :dislike
      t.datetime :date

      t.references :function, index: true

      t.timestamps
    end
  end
end
