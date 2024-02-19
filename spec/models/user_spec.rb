require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tasks).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'validations' do

    it 'email should be unique' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password')
      user2 = User.new(name: 'test', email: user.email, password: 'password')

      expect(user2).to_not be_valid
    end
  end

  describe 'before_validation' do
    it 'should downcase email' do
      user = User.new(name: 'test', email: 'TEST@example.com', password: 'password')

      user.valid?
      expect(user.email).to eq 'test@example.com'
    end
  end

end
