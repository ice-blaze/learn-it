class RenameReferenceFunctionVote < ActiveRecord::Migration
  def change
    remove_reference :function_votes, :part, index: true
    add_reference :function_votes, :function, index: true
  end
end
