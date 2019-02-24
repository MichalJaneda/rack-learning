RSpec.describe Action::User::List do
  let(:returned_emails) { json_response.map { |user| user['email'] } }

  it { expect(json_response).to be_empty }

  context 'users existing' do
    let!(:users) do
      [
        create(:user, email: 'A@example.com'),
        *create_list(:user, 18),
        create(:user, email: 'z@example.com')
      ]
    end

    it { expect(json_response.count).to eq(10) }

    context 'params' do
      let(:email) { users.first.email }

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

        it { expect(returned_emails).to contain_exactly(users.map(&:email).sort[1]) }
      end
    end
  end
end
