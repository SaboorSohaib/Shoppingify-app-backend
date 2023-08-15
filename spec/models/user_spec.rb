require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Abid', email: 'abid@gmail.com', password: '123456')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with a password less than 6 characters' do
    @user.password = '123'
    expect(@user).to_not be_valid
  end

  it 'is valid with a name more than 3 characters' do
    @user.name = 'Ali'
    expect(@user).to be_valid
  end

  it 'should have many lists' do
    user = User.reflect_on_association(:lists)
    expect(user.macro).to eq(:has_many)
  end
end
