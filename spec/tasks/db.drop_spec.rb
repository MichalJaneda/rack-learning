RSpec.describe 'db:drop', type: :task do
  describe '.invoke' do
    let!(:db_name) { 'some_random_db_name_ensure_that_this_does_not_exist' }

    subject { rake[task_name].invoke }

    before { stub_const('::Value::Query::DB::NAME', db_name) }

    context 'database does not exists' do
      it 'raises error' do
        system("dropdb #{db_name} 2> /dev/null")
        expect { subject }.to raise_error(CommandExecutionError)
      end
    end

    context 'database already exists' do
      it 'drops database' do
        system("createdb #{db_name} 2> /dev/null")
        expect { subject }.to_not raise_error
      end
    end
  end
end
