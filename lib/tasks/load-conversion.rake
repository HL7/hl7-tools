require 'csv'

namespace :data do
  desc 'Generate the load files from CSV saves of the Excel spreadsheets'
  task conversion: [:tool_conversion, :person_conversion, :responsibility_conversion]

  desc 'Generate the main Tool load files from the csv Excel output of the capture spreadsheet'
  task tool_conversion: ['db/data-conversion/tools.csv'] do
    puts 'Beginning generation of tools load file....'
    rec_cnt = 0
    note_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-01-tools.csv', 'w')
    new_csv << %w(id name description purpose url support_url version internal
                  functional_area active license aka
                  product rollout_date last_update_date created_at updated_at)
    notes_csv = CSV.open(Rails.root + 'db/load-data/02-03-tool_notes.csv', 'w')
    notes_csv << %w(id tool_id note note_date author)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec || row[0] == 'xx'
        new_csv << [ row[0], row[1], row[2], row[3], row[4], row[5], row[7],row[8],
                     wrap_array_type(row[9]), row[10], row[11], wrap_array_type(row[12]),
                     wrap_array_type(row[14]), row[15], row[16],
                     row[17], row[17] ]
        rec_cnt += 1
        if row[20]
          note_cnt += 1
          notes_csv << [ note_cnt, row[0], row[20], row[17], 'initial load' ]
        end
      end
      first_rec = false
    end
    new_csv.close
    notes_csv.close
    puts "Generation of Tools complete, wrote #{rec_cnt} records"

    puts 'Beginning generation of tool technologies load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-02-tool_technologies.csv', 'w')
    new_csv << %w(id tool_id technology tech_version note)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec || row[0] == 'xx'
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

    puts 'Beginning generation of tool dependencies load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/02-02-tool_dependencies.csv', 'w')
    new_csv << %w(id tool_id dependency_id note)
    CSV.foreach(Rails.root + 'db/data-conversion/tools.csv') do |row|
      unless first_rec || row[0] == 'xx'
        if row[18]
          dep_list = row[18].split
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

  desc 'Generate the Person Org load files from the csv Excel output'
  task person_conversion: ['db/data-conversion/persons.csv'] do
    puts 'Beginning generation of Persons/Organizations load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/01-02-person_orgs.csv', 'w')
    new_csv << %w(id name contact_phone contact_email is_organization active notes created_at updated_at)
    CSV.foreach(Rails.root + 'db/data-conversion/persons.csv') do |row|
      unless first_rec || row[0] == 'xx'
        new_csv << [ row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[7] ]
        rec_cnt += 1
      end
      first_rec = false
    end
    new_csv.close
    puts "Generation of Persons/Organizations complete, wrote #{rec_cnt} records"
  end

  desc 'Generate the Tool  load files from the csv Excel output'
  task responsibility_conversion: ['db/data-conversion/tool-responsibilities.csv'] do
    puts 'Beginning generation of Tool Responsibilities load file....'
    rec_cnt = 0
    first_rec = true
    new_csv = CSV.open(Rails.root + 'db/load-data/03-01-tool_people.csv', 'w')
    new_csv << %w(id tool_id person_org_id role activity notes updated_at)
    CSV.foreach(Rails.root + 'db/data-conversion/tool-responsibilities.csv') do |row|
      unless first_rec || row[0] == 'xx'
        new_csv << [ row[0], row[1], row[3], row[5], row[6], row[7] ]
        rec_cnt += 1
      end
      first_rec = false
    end
    new_csv.close
    puts "Generation of Tool Responsibilities complete, wrote #{rec_cnt} records"
  end
end

file 'db/data-conversion/tools.csv' => ['db/data-conversion/tools-raw.csv'] do |f|
  puts "Generating #{f.name} from #{f.prerequisites[0]}"
  system "iconv -f MACROMAN -t UTF8 #{f.prerequisites[0]} | tr '\r' '\n' >#{f.name}"
end

file 'db/data-conversion/persons.csv' => 'db/data-conversion/persons-raw.csv' do |f|
  puts "Generating #{f.name} from #{f.prerequisites[0]}"
  system "iconv -f MACROMAN -t UTF8 #{f.prerequisites[0]} | tr '\r' '\n' >#{f.name}"
end

file 'db/data-conversion/tool-responsibilities.csv' => 'db/data-conversion/tool-responsibilities-raw.csv' do |f|
  puts "Generating #{f.name} from #{f.prerequisites[0]}"
  system "iconv -f MACROMAN -t UTF8 #{f.prerequisites[0]} | tr '\r' '\n' >#{f.name}"
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