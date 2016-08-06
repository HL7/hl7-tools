class CreateToolPeople < ActiveRecord::Migration
  def change
    create_table :tool_people do |t|
      t.references :tool, null: false
      t.references :person_org, null: false
      t.string     :role, null: false, limit: 20, array: true
      t.integer    :activity, null: false, default: 0
      t.string     :notes
      t.datetime   :updated_at, null: false

      t.index [:tool_id, :person_org_id], unique: true
    end
  end
end
