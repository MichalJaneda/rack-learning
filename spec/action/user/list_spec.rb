RSpec.describe Action::User::List do
  let(:returned_emails) { json_response.map { |user| user['email'] } }

  it { expect(json_response).to be_empty }

  context 'users existing' do
    let!(:inserts) { Query::Repository::Users.import(%i(name email), users) }

    let(:users) { Array.new(20) { |i| [Faker::Name.name, "name.#{(i + 64).chr}@example.com"] } }

    it { expect(json_response.count).to eq(10) }

    context 'params' do
      let(:email) { users.first.last }

      context 'filter' do
        context 'after first email' do
          let(:params) { { where: { after: { email: email } } } }

          it { expect(json_response.count).to eq(10) }

          it { expect(returned_emails).to_not include(email) }
        end
      end

      context 'pagination' do
        context 'limits to one' do
          let(:params) { { where: { limit: 1 } } }

          it { expect(json_response.count).to eq(1) }

          it { expect(returned_emails).to contain_exactly(email) }
        end
      end

      context 'filter and pagination' do
        let(:params) { { where: { after: { email: email }, limit: 1 } } }

        it { expect(json_response.count).to eq(1) }

        it { expect(returned_emails).to contain_exactly(users[1].last) }
      end
    end
  end
end
