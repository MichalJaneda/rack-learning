RSpec.describe 'db:create', type: :task do
  describe '.invoke' do
    let!(:db_name) { 'some_random_db_name_ensure_that_this_does_not_exist' }

    subject { rake[task_name].invoke }

    before do
      stub_const('::Value::Query::DB::NAME', db_name)
      system("dropdb #{db_name}")
    end

    context 'database does not exists' do
      it 'creates new database' do
        expect { subject }.to_not raise_error(StandardError)
      end
    end

    context 'database already exists' do
      it 'raises error' do
        rake[task_name].invoke
        expect { subject }.to_not raise_error(StandardError)
      end
    end
  end
end
