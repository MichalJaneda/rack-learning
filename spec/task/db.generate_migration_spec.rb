RSpec.describe 'db:generate_migration' do
  describe '.invoke' do
    let!(:migrations_dir) { "#{Dir.pwd}/db/migrations" }
    let!(:current_time) { Time.now }

    let(:migration_name) { nil }

    subject { rake[task_name].invoke(migration_name) }

    around(:each) { |example| Timecop.freeze(current_time) { example.run } }

    context 'no migration name provided' do
      it { expect { subject }.to raise_error(InvalidTaskParamsError, 'name missing') }
    end

    context 'migration name provided' do
      let(:migration_name) { 'create users table' }
      let(:expected_file_name) { "#{current_time.to_i}_create_users_table.rb" }
      let(:empty_migration_content) do
        <<~MIGRATION
        Sequel.migration do
          up do
          end

          down do
          end
        end
        MIGRATION
      end

      before { File.stub(:write) }

      it 'creates new migration file' do
        subject
        expect(File)
          .to have_received(:write)
          .with("#{migrations_dir}/#{expected_file_name}", empty_migration_content)
          .once
      end
    end
  end
end
