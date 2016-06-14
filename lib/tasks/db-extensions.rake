class Temp < ActiveRecord::Base;end

namespace :db do
  namespace :csv do
    desc 'A task to load data from a numbered set of CSV files'
    task :load => [:migrate] do |t|
      Rake::Task['db:csv:plain_load'].invoke
    end

    desc 'A task to load data from a numbered set of CSV files'
    task :plain_load => [:environment] do
      Dir.glob(Rails.root + 'db/load-data/*.csv').each do |file|
        load_table(file)
      end
      Rake::Task['db:csv:adjust_sequences'].invoke
    end

    task :table_clear => [:environment] do
      table_list = []
      Dir.glob(Rails.root + 'db/load_data/*.csv').each do |file|
        table = parse_table_name(file)
        table_list << table
      end

      table = table_list.pop
      while table do
        puts "Deleting all content from #{table}"
        ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
        table = table_list.pop
      end
    end

    task :adjust_sequences => :environment do
      ActiveRecord::Base.connection.query('SELECT t.relname from pg_class t' +
                                              " where t.relkind = 'S'").each do |sequence|
        table = sequence[0].gsub(/_id_seq$/i, '')
        count = Temp.count_by_sql("SELECT MAX(id) FROM #{table}")
        puts "Updating sequence -> #{sequence[0]} for table #{table} to #{count}" if count > 0
        ActiveRecord::Base.connection.execute("select setval('#{sequence[0]}', #{count})") if count > 0
      end
    end

    desc 'Clean out the database, reload from CSV files and setup for processing'
    task :clean_load => [:table_clear] do
      Rake::Task['db:csv:load'].invoke
    end

    desc 'Pull all of the tables out of the database into a directory'
    task :extract => :environment  do
      ignored = %w(schema_migrations code_values, contacts)
      puts "Ignored: #{ignored}"
      ActiveRecord::Base.connection.tables.each do |table|
        count = Temp.count_by_sql("SELECT COUNT(*) FROM #{table}")
        ActiveRecord::Base.connection.execute("COPY (SELECT * from #{table} order by id) TO '#{Rails.root}/db//extract-data/#{table}.csv' CSV HEADER") if count > 0 and !ignored.include?(table)
        puts "#{table} extracted" if count > 0 and !ignored.include?(table)
      end
    end

    desc 'Run an extract and comparison to update saved extract data'
    task :compare_extract => :extract do
      puts 'Comparing extracted data with current CSV backup'
      load_files = {}
      Dir.glob(Rails.root + 'db/load-data/*.csv').each do |file|
        plain_name = File.basename(file, '.csv')
        plain_name.slice!(/[0-9]+-/)
        load_files[plain_name] = file
      end
      Dir.glob(Rails.root + 'db/extract-data/*.csv').each do |file|
        table = File.basename(file, '.csv')
        puts "Compare #{table}"
        if load_files.has_key?(table)
          if system("diff #{file} #{load_files[table]}")
            puts "No changes in #{table}"
            rm file
          else
            puts "Need to update #{table}"
            mv file, load_files[table], verbose: true
          end
        end
      end
    end
  end
end


def load_table(file_name)
  table = parse_table_name(file_name)
  if File.exist?(file_name)
    puts "Loading #{table} ...."
    ActiveRecord::Base.connection.execute("COPY #{table} FROM '#{file_name}' CSV HEADER")
  end
end

def parse_table_name(file_name)
  table = File.basename(file_name, '.csv')
  table.slice!(/([0-9]+-)+/)
  table
end