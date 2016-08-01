class CreatePersonOrgs < ActiveRecord::Migration
  def change
    create_table :person_orgs do |t|
      t.string  :name, null: false
      t.string  :contact_phone, limit: 20
      t.string  :contact_email, limit: 60
      t.boolean :is_organization, null: false, default: false
      t.boolean :active, null: false, default: true
      t.text    :notes

      t.timestamps null: false
    end
  end
end
