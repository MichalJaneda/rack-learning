module SharedContext
  module Task
    extend RSpec::SharedContext

    let(:rake) { Rake::Application.new }
    let(:task_name) { self.class.top_level_description }
    let(:task_path) { "rakelib/#{task_name.split(':').first}" }

    subject { rake[task_name] }

    def loaded_files_excluding_current_rake_file
      $".reject { |file| file == "#{Dir.pwd}/#{task_path}.rake" }
    end

    before do
      Rake.application = rake
      Rake.application.rake_require(task_path,
                                    [Dir.pwd],
                                    loaded_files_excluding_current_rake_file)

      Rake::Task.define_task(:environment)
    end
  end
end
