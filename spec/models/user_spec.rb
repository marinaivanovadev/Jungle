require 'rails_helper'

RSpec.describe User, type: :model do
  
describe 'Validations' do
    it 'all attributes' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password',
      
      )
      expect(user).to be_valid
    end
    
    it 'is invalid without a password' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

        it 'password has to be the same with password confirmation' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password1',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'require an email' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it 'is invalid with a duplicate email or case-sensitive' do
      User.create(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email:  'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
        
      )
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'Marina.ivanova.ca@gmail.com',
        password: 'password2',
        password_confirmation: 'password2',
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Email has already been taken')
    end



  end
end


