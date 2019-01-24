namespace :db do
  desc 'Create new database, raise error if failed'
  task :create do
    _stdin, stdout, stderr = Open3.capture3("createdb #{::Value::Query::DB::NAME};")
    raise StandardError stdout unless stderr.to_i.zero?
  end
end
