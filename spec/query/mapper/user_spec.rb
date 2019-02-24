RSpec.describe Query::Mapper::User do
  let(:entities) { [attributes_for(:user)] }

  subject { described_class.new(entities).() }

  it { expect(subject.count).to eq(entities.count) }

  it { is_expected.to all(be_instance_of(Model::User)) }
end
