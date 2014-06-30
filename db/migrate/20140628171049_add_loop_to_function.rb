class AddLoopToFunction < ActiveRecord::Migration
  def change
    add_column :functions, :loop, :boolean
  end
end
