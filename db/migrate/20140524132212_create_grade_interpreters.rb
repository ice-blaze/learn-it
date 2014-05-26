class CreateGradeInterpreters < ActiveRecord::Migration
  def change
    create_table :grade_interpreters do |t|
      t.float :grade

      t.references :user, index: true
      t.references :interpreter, index: true

      t.timestamps
    end
  end
end
