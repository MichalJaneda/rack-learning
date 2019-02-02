RSpec.describe Action::User::List do
  it { expect(json_response).to be_empty }

  context 'users existing' do
    before(:all) do
      to_insert = Array.new(3) { |i| [Faker::Name.name, "name.#{i}@example.com"] }
      Query::Repository::Users.import(%i(name email), to_insert)
    end

    it { expect(json_response.count).to eq(3) }
  end
end
