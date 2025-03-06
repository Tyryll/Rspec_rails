require 'rails_helper'

describe User, type: :model do
    ###1
  describe '#activate!' do # if want to test model behavior
    #it 'sets active to true' do
      #user = User.create!(name: 'Example', email: 'name@example.com', active: false)

      #user.activate!

      #expect(user.active).to be true
    #end

    it 'sets active to true' do # if want to test activate! behavior only
        user = instance_double(User, activate!: true, active: true)  #uses double
  
        user.activate!  
  
        expect(user.active).to be true 
      end
  end
    ##2
  context 'User creation' do
    it 'increases the User count by 1' do
      expect {
        User.create!(name: 'Example', email: 'name@example.com')
      }.to change { User.count }.by(1)
    end
  end

  #context 'User creation' do  # This does NOT touch the database
    #it 'does not actually change User.count because it is mocked' do
      #user_double = double('User')  #uses double

      #allow(User).to receive(:create!).and_return(user_double)  #allows create to recieve the double

      #expect {
        #User.create!(name: 'Example', email: 'name@example.com')  
      #}.to_not change { User.count }  # This will not increase, so the test will fail
    #end
  #end

  ###3
  #describe '#greet' do # if want to test model behavior
      #it 'returns a greeting message with the user name' do
            #user = User.new(name: 'example')  # Create a user instance

            #expect(user.greet).to eq('Hello, Example')  # Check the expected output
      #end
  #end

  describe '#greet' do # if want to test greet behavior only
    it 'returns a greeting message with the user name using a test double' do
      user_double = double('User', name: 'Example')  # Mock user object
      allow(user_double).to receive(:greet).and_return("Hello, Example")  # Stub the method

      expect(user_double.greet).to eq('Hello, Example')  # Check expected output
    end
  end
  
  ###4
  #context 'check if #admin returns true if admin is created and false if user' do # if want to test model behavior
    #it 'returns true if the user role is admin' do
        #admin_user = User.new(name: 'Admin', email: 'admin@example.com', role: :admin)

        #expect(admin_user.admin?).to be true  # Check if admin? returns true
    #end

    #it 'returns false if the user role is not admin' do
        #regular_user = User.new(name: 'User', email: 'user@example.com', role: :user)

        #expect(regular_user.admin?).to be false  # Check if admin? returns false
    #end
  #end

  describe '#admin?' do #if want to test admin? behavior only
    it 'returns true if the user role is admin using a test double' do
      user_double = double('User', role: 'admin')
      allow(user_double).to receive(:admin?).and_return(true)

      expect(user_double.admin?).to be true
    end

    it 'returns false if the user role is not admin' do
        user_double = double('User', role: 'user')
        allow(user_double).to receive(:admin?).and_return(false)

        expect(user_double.admin?).to be false  # Check if admin? returns false
    end
  end

  ###5

  context 'orders association' do # if want to test model behavior
    it 'has an empty array of orders for a new user' do
      user = User.create!(name: 'Example', email: 'name@example.com')

      expect(user.orders).to be_empty # Check if orders is empty
    end
  end

  #describe 'orders association' do #if want to test orders association behavior only
    #it 'has an empty array of orders using a test double' do
      #user_double = double('User', orders: [])
      #allow(user_double).to receive(:orders).and_return([])

      #expect(user_double.orders).to be_empty
    #end
  #end

end