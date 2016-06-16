class AddTextIndices < ActiveRecord::Migration
  def up
    execute "create index tool_txt_idx on tools using gin(to_tsvector('english', coalesce(name,' ') || coalesce(description,' ') || coalesce(purpose,' ') ))"
    # execute "create index sow_doctors_txt on sow_doctor_lists using gin(to_tsvector('english', doctors))"
    # execute "create index clinics_name_txt on clinics using gin(to_tsvector('english', name || coalesce(alias, ' ')))"
  end

  def down
    execute 'drop index tool_txt_idx'
    # execute "drop index sow_doctors_txt"
    # execute "drop index clinics_name_txt"
  end
end
