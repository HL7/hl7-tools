class AddTextIndices < ActiveRecord::Migration
  def up
    execute "create index tool_txt_idx on tools using gin(to_tsvector('english', coalesce(name,' ') || coalesce(description,' ') || coalesce(purpose,' ') || coalesce(aka,' ') ))"
  end

  def down
    execute 'drop index tool_txt_idx'
  end
end
