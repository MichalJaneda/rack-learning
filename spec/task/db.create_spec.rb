RSpec.describe 'db:create' do
  describe '.invoke' do
    let!(:db_name) { 'some_random_db_name_ensure_that_this_does_not_exist' }

    subject { rake[task_name].invoke }

    before { stub_const('::Value::Query::DB::NAME', db_name) }

    context 'database does not exists' do
      it 'creates new database' do
        system("dropdb #{db_name} 2> /dev/null")
        expect { subject }.to_not raise_error
      end
    end

    context 'database already exists' do
      it 'raises error' do
        system("createdb #{db_name} 2> /dev/null")
        expect { subject }.to raise_error(CommandExecutionError)
      end
    end
  end
end
