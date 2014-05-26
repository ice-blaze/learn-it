class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.text :regex
      t.text :content

      t.references :interpreter, index: true

      t.timestamps
    end
  end
end
