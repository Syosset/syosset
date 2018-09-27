RSpec.describe User do
  it 'can be created with valid parameters' do
    user = build(:student)
    expect(user).to be_valid
  end

  it 'requires a name' do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it 'requires an email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  context 'with a staff email' do
    let(:user) { build(:staff) }

    it '#staff?' do
      expect(user.staff?).to be(true)
    end

    it 'generates a valid username' do
      expect(user.username).to eq('flast')
    end
  end

  context 'without a staff email' do
    let(:user) { build(:student) }

    it '#staff?' do
      expect(user.staff?).to be(false)
    end

    it 'does not generate a username' do
      expect(user.username).to be_nil
    end
  end
end
