class AddPositionToFunction < ActiveRecord::Migration
  def change
    add_column :functions, :position, :integer
  end
end
