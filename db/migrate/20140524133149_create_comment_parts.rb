class CreateCommentParts < ActiveRecord::Migration
  def change
    create_table :comment_parts do |t|
      t.text :content
      t.integer :like
      t.integer :dislike
      t.datetime :date

      t.references :part, index: true

      t.timestamps
    end
  end
end
