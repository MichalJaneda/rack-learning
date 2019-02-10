RSpec.describe Filter::After do
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
