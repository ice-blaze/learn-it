class CreateGradeTutorials < ActiveRecord::Migration
  def change
    create_table :grade_tutorials do |t|
      t.float :grade

      t.references :user, index: true
      t.references :tutorial, index: true

      t.timestamps
    end
  end
end
