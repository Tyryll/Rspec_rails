require 'rails_helper'

describe User, type: :model do
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
  
end