class AddUserReferencesToComments < ActiveRecord::Migration
  def change
    add_reference :tutorial_comments, :user, index: true

    add_reference :part_comments, :user, index: true

    add_reference :interpreter_comments, :user, index: true

    add_reference :function_comments, :user, index: true
  end
end
