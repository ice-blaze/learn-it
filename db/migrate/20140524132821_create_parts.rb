class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title
      t.text :content
      t.text :signature

      t.references :tutorial, index: true

      t.timestamps
    end
  end
end
