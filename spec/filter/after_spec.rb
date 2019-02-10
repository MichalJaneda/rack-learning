RSpec.describe Filter::After do
  let(:params) { { where: {} } }

  let(:query) { Sequel.mock.dataset.from(:test).extension(:sequel_4_dataset_methods) }

  describe '#call' do
    subject { described_class.new(query, params[:where]).call.sql }

    context 'empty params' do
      it { is_expected.to eq(query.sql) }
    end

    context 'params match' do
      let(:user_name) { Faker::Name.name }
      let(:params) { { where: { after: { name: user_name } } } }

      it { is_expected.to include("WHERE (name > '#{user_name}')") }

      context 'multiple options passed' do
        let(:last_name) { Faker::Name.last_name }
        let(:params) { { where: { after: { name: user_name, surname: last_name } } } }

        it { is_expected.to include("WHERE ((name > '#{user_name}') AND (surname > '#{last_name}'))") }
      end
    end
  end
end
