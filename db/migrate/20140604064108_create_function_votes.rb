class CreateFunctionVotes < ActiveRecord::Migration
  def change
    create_table :function_votes do |t|

      t.timestamps
    end


  end
end
