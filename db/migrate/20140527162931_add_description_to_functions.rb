class AddDescriptionToFunctions < ActiveRecord::Migration
  def change
    add_column :functions, :description, :string
  end
end
