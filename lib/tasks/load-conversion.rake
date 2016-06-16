require 'csv'

namespace :data do
  desc 'thing'
  task :tool_conversion do
    puts 'Beginning generation of tools load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-01-tools.csv', 'w')
    new_csv << %w(id name description purpose url support_url version internal
                  functional_area product rollout_date last_update_date created_at updated_at)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec
        new_csv << [ row[0], row[1], row[2], row[3], row[4], row[5], row[7],row[8],
                     wrap_array_type(row[9]), wrap_array_type(row[11]), row[12], row[13],
                     row[14], row[14] ]
        rec_cnt += 1
      end
      first_rec = false
    end
    new_csv.close
    puts "Generation of Tools complete, wrote #{rec_cnt} records"

    puts 'Beginning generation of tool technologies load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-02-tool_technologies.csv', 'w')
    new_csv << %w(id tool_id technology tech_version note)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec
        if row[6]
          tech_list = row[6].split
          tech_list.each do |tech_item|
            new_csv << [ rec_cnt + 1, row[0], tech_item, nil, nil ]
            rec_cnt += 1
          end
        end
      end
      first_rec = false
    end
    new_csv.close
    puts "Generation of Tool Technologies complete, wrote #{rec_cnt} records"

    puts 'Beginning generation of tool technologies load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-02-tool_dependencies.csv', 'w')
    new_csv << %w(id tool_id dependency_id note)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec
        if row[15]
          dep_list = row[15].split
          dep_list.each do |dep_item|
            new_csv << [ rec_cnt + 1, row[0], dep_item, nil ]
            rec_cnt += 1
          end
        end
      end
      first_rec = false
    end
    new_csv.close
    puts "Generation of Tool Dependencies complete, wrote #{rec_cnt} records"
  end
end

def wrap_array_type(array_fld)
  formatted_fld = nil
  unless array_fld.nil?
    the_list = array_fld.split
    the_list = the_list.map { |item| '"' + item + '"' }
    formatted_fld = '{' + the_list.join(',') + '}'
  end
  formatted_fld
end