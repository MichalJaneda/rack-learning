namespace :db do
  desc 'Create new database, raise error if failed'
  task :create do
    run_command!("createdb #{::Value::Query::DB::NAME};")
  end

  desc 'Drop database, raise error if failed'
  task :drop do
    run_command!("dropdb #{::Value::Query::DB::NAME};")
  end

  desc 'Create new migration file in format <timestamp>_<name>'
  task :generate_migration, [:name] do |_t, args|
    raise InvalidTaskParamsError, 'name' unless args.name
    file_name = "#{Time.now.to_i}_#{args.name.gsub(' ', '_')}.rb"
    File.write("#{Dir.pwd}/db/migrations/#{file_name}", <<~MIGRATION
        Sequel.migration do
          up do
          end

          down do
          end
        end
        MIGRATION
        )
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    Sequel.extension (:migration)
    Sequel::TimestampMigrator.new(Connection.get_connection,
                                  'db/migrations',
                                  { target: args.version&.to_i })
      .run
  end

  private

  # @param [String] command
  # @return [Hash]
  # @raise [CommandExecutionError] if command response code not eq to 0
  def run_command!(command)
    execution = Open3.capture3(command)
    raise CommandExecutionError, execution[1] unless execution[2].to_i.zero?
    {
      stdin: execution[0],
      stdout: execution[1],
      stderr: execution[2]
    }
  end
end
