class CreateInterpreters < ActiveRecord::Migration
  def change
    create_table :interpreters do |t|
      t.string :title
      t.text :description
      t.boolean :is_finish
      t.string :open_token
      t.string :close_token

      t.references :user, index: true

      t.timestamps
    end
  end
end
