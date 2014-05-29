class CreateDoneParts < ActiveRecord::Migration
  def change
    create_table :done_parts do |t|

      t.timestamps
    end

    add_reference :done_parts, :user, index: true
    add_reference :done_parts, :part, index: true
  end
end
