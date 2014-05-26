class AddVersion < ActiveRecord::Migration
  def change
    add_column :tutorials, :version, :integer
    add_column :interpreters, :version, :integer
  end
end
