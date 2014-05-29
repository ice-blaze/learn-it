class RenameGrades < ActiveRecord::Migration
  def change
    rename_table :grade_interpreters, :interpreter_grades
    rename_table :grade_tutorials, :tutorial_grades
  end
end
