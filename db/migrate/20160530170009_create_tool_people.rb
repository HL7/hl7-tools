class CreateToolPeople < ActiveRecord::Migration
  def change
    create_table :tool_people do |t|
      t.references :tool, null: false
      t.references :person_org, null: false
      t.string     :role, null: false, limit: 20
      t.integer    :activity, null: false, default: 0
    end
  end
end
