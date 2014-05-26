class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :description
      t.boolean :is_finish

      t.references :user, index: true

      t.timestamps
    end
  end
end
