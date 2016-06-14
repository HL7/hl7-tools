class CreateCodeValues < ActiveRecord::Migration
  def change
    create_table :code_values do |t|
      t.string      :code_table, limit: 30, null: false
      t.string      :code, limit: 20, null: false
      t.string      :long_value, limit: 30
      t.string      :description, limit: 100
      t.string      :print_name, limit: 60
      t.references  :parent

      t.index [:code_table, :code], unique: true
    end

    execute 'ALTER TABLE code_values ADD FOREIGN KEY (parent_id) references code_values(id)'

    reversible do |dir|
      dir.up do
        execute "COPY code_values FROM '#{File.expand_path('./db/base-data/code_values.csv')}' CSV HEADER"
      end
    end
  end
end
