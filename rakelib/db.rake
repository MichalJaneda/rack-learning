namespace :db do
  desc 'Create new database, raise error if failed'
  task :create do
    _stdin, stdout, stderr = Open3.capture3("createdb #{::Value::Query::DB::NAME};")
    raise CommandExecutionError, stdout unless stderr.to_i.zero?
  end

  desc 'Drop database, raise error if failed'
  task :drop do
    _stdin, stdout, stderr = Open3.capture3("dropdb #{::Value::Query::DB::NAME};")
    raise CommandExecutionError, stdout unless stderr.to_i.zero?
  end
end
