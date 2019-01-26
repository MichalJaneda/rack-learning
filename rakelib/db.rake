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
  task :generate_migration, [:name] do |_task, args|
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

  private

  # @param [String] command
  # @return [Hash]
  # @raise [CommandExecutionError] if command response code not eq to 0
  def run_command!(command)
    execution = Open3.capture3(command)
    raise CommandExecutionError, execution.second unless execution.last.to_i.zero?
    {
      stdin: execution.first,
      stdout: execution.second,
      stderr: execution.last
    }
  end
end
