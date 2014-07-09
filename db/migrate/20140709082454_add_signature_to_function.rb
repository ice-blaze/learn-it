class AddSignatureToFunction < ActiveRecord::Migration
  def change
    add_column :functions, :signature, :boolean
  end
end
