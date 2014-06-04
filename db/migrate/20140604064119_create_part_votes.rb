class CreatePartVotes < ActiveRecord::Migration
  def change
    create_table :part_votes do |t|

      t.timestamps
    end

    add_column :part_votes, :positive, :boolean
    add_column :function_votes, :positive, :boolean

    add_reference :part_votes, :user, index: true
    add_reference :part_votes, :part, index: true

    add_reference :function_votes, :user, index: true
    add_reference :function_votes, :part, index: true
  end
end
