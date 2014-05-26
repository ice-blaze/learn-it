class AddReferences < ActiveRecord::Migration
  def change
    add_column :tutorials, :interpreter_id, :string
    add_index :tutorials, :interpreter_id
  end
end
