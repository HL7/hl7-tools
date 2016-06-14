require 'csv'

namespace :data do
  desc 'thing'
  task :tool_conversion do
    puts 'Beginning generation of tools load file....'
    rec_cnt = 0
    new_csv = CSV.open(Rails.root + 'db/load-data/02-01-tools.csv', 'w')
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      new_csv << [ row[0], row[1], row[2], row[3], row[4], row[5], row[6],
                   wrap_array_type(row[7]), wrap_array_type(row[8]), row[9], row[10],
                   row[11], row[12] ]
      rec_cnt += 1
    end
    new_csv.close
    puts "Generation complete, wrote #{rec_cnt} records"
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