class CreateCommentInterpreters < ActiveRecord::Migration
  def change
    create_table :comment_interpreters do |t|
      t.text :content
      t.integer :like
      t.integer :dislike
      t.datetime :date

      t.references :interpreter, index: true

      t.timestamps
    end
  end
end
