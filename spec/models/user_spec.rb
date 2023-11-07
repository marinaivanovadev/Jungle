require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'all attributes' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'      
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
    
    it 'is invalid without a first name' do
      user = User.new(
        last_name: 'Ivanova',
        email:  'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'is invalid without a last name' do
      user = User.new(
        first_name: 'Marina',
        email: 'Marina.ivanova.ca@gmail.com',
        password: 'password2',
        password_confirmation: 'password2',
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid with a password less than 8 characters' do
      user = User.new(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email:  'marina.ivanova.ca@gmail.com',
        password: 'new',
        password_confirmation: 'new'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
    end
  end
  
  describe '.authenticate_with_credentials' do
    it 'returns the user when credentials are valid' do
      user = User.create(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('marina.ivanova.ca@gmail.com', 'password')
      expect(authenticated_user).to eq(user)
    end
    
    it 'returns nil when email is not found' do
      authenticated_user = User.authenticate_with_credentials('nil@gmail.com', 'password')
      expect(authenticated_user).to be_nil
    end
    
    it 'returns nil when password is incorrect' do
      user = User.create(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('marina.ivanova.ca@gmail.com', 'other_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns the user when email has spaces before and/or after' do
      user = User.create(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('  marina.ivanova.ca@gmail.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns the user when email is entered  in the wrong case' do
      user = User.create(
        first_name: 'Marina',
        last_name: 'Ivanova',
        email: 'marina.ivanova.ca@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('mArInA.IvanOVA.ca@GMail.CoM', 'password')
      expect(authenticated_user).to eq(user)
  end
end
end


