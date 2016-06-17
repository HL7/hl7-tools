class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string  :name, null: false
      t.string  :description
      t.string  :purpose
      t.string  :url
      t.string  :support_url
      t.string  :version
      t.boolean :internal, null: false, default: true
      t.string  :functional_area, limit: 15, array: true
      t.string  :product, limit: 15, array: true
      t.date    :rollout_date
      t.date    :last_update_date

      t.timestamps null: false
    end

    create_table :tool_technologies do |t|
      t.references :tool, null: false
      t.string     :technology, limit: 20, null: false
      t.string     :tech_version, limit: 30
      t.text       :note
    end

    create_table :tool_notes do |t|
      t.references :tool, null: false
      t.text       :note, null: false
      t.date       :note_date, null: false
      t.string     :author, limit: 60
    end

    create_table :tool_assessments do |t|
      t.references :tool, null: false
      t.date       :assessment_date, null: false
      t.boolean    :required, null: false, default: true
      t.integer    :risk, null: false, default: 0
      t.integer    :quality, null: false, default: 0
      t.integer    :sustainability, null: false, default: 0
      t.integer    :usability, null: false, default: 0
      t.text       :note
    end

    create_table :tool_dependencies do |t|
      t.references :tool, null: false
      t.references :dependency, null: false
      t.text       :note
    end
  end
end
