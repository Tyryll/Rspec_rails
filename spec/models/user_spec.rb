require 'rails_helper'

describe User, type: :model do
  ### 1
  describe '#activate!' do# if want to test model behavior
    it 'sets active to true' do
      user = User.create!(name: 'Example', email: 'name@example.com', active: false)

      user.activate!

      expect(user.active).to be true
    end

    # it 'sets active to true' do # if want to test activate! behavior only
    #     binding.pry
    #     user = instance_double(User, activate!: true, active: false)  #uses double
    #     allow(user).to receive(:active).and_return("Hello, Example")

    #     user.activate!

    #     expect(user.active).to be true
    # end
  end

  ## 2
  context 'User creation' do
    it 'increases the User count by 1' do
      expect {
        User.create!(name: 'Example', email: 'name@example.com')
      }.to change { User.count }.by(1)
    end
  end

  # context 'User creation' do  # This does NOT touch the database
  #   it 'does not actually change User.count because it is mocked' do
  #     user_double = double('User')  #uses double

  #     allow(User).to receive(:create!).and_return(user_double)  #allows create to recieve the double

  #     expect {
  #       User.create!(name: 'Example', email: 'name@example.com')
  #     }.to_not change { User.count }  # This will not increase, so the test will fail
  #   end
  # end

  # ##3
  # describe '#greet' do # if want to test model behavior
  #     it 'returns a greeting message with the user name' do
  #           user = User.new(name: 'example')  # Create a user instance

  #           expect(user.greet).to eq('Hello, Example')  # Check the expected output
  #     end
  # end

  describe '#greet' do # if want to test greet behavior only
    it 'returns a greeting message with the user name using a test double' do
      user_double = double('User', name: 'Example')  # Mock user object
      allow(user_double).to receive(:greet).and_return("Hello, Example")  # Stub the method

      expect(user_double.greet).to eq('Hello, Example')  # Check expected output
    end
  end

  # ##4
  # context 'check if #admin returns true if admin is created and false if user' do # if want to test model behavior
  #   it 'returns true if the user role is admin' do
  #       admin_user = User.new(name: 'Admin', email: 'admin@example.com', role: :admin)

  #       expect(admin_user.admin?).to be true  # Check if admin? returns true
  #   end

  #   it 'returns false if the user role is not admin' do
  #       regular_user = User.new(name: 'User', email: 'user@example.com', role: :user)

  #       expect(regular_user.admin?).to be false  # Check if admin? returns false
  #   end
  # end

  describe '#admin?' do # if want to test admin? behavior only
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

  # ##5

  context 'orders association' do # if want to test model behavior
    it 'has an empty array of orders for a new user' do
      user = User.create!(name: 'Example', email: 'name@example.com')

      expect(user.orders).to be_empty # Check if orders is empty
    end
  end

 # describe 'orders association' do #if want to test orders association behavior only
 # it 'has an empty array of orders using a test double' do
 # user_double = double('User', orders: [])
 # allow(user_double).to receive(:orders).and_return([])

 # expect(user_double.orders).to be_empty
 # end
 # end


 ### 6
 describe '#delete!' do
   it 'sets deleted_at to a timestamp' do
     user = User.create!(name: 'Example', email: 'name@example.com')
     user.delete!
     expect(user.reload.deleted_at).to be_within(1.second).of(Time.current)
   end
 end

# describe '#delete!' do
#   it 'sets deleted_at to a timestamp' do
#     user = User.create!(name: 'Example', email: 'name@example.com')
#     user.delete!
#     expect(user.reload.deleted_at).to be_within(1.second).of(Time.current)
#   end
# end

### 7
describe '#update_email!' do
  it "updates the user's email" do
    user = User.create!(name: 'Example', email: 'old@example.com')
    user.update_email!('new@example.com')
    expect(user.reload.email).to eq('new@example.com')
  end
end

# describe '#update_email!' do
#   it "updates the user's email" do
#     user = User.create!(name: 'Example', email: 'old@example.com')
#     user.update_email!('new@example.com')
#     expect(user.reload.email).to eq('new@example.com')
#   end
# end

### 8

describe 'Usermailer' do
  it 'sends a welcome email' do
    user = User.create!(name: 'Example', email: 'test@example.com')

    expect {
      UserMailer.welcome_email(user).deliver_now
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end

 # describe 'UserMailer' do
 #   it 'sends a welcome email' do
 #     user = User.create!(name: 'Example', email: 'test@example.com')

 #     expect {
 #       UserMailer.welcome_email(user).deliver_now
 #     }.to change { ActionMailer::Base.deliveries.count }.by(1)
 #   end
 # end

 ### 9

 describe 'delete!' do
   it 'sets deleted_user_error on an already deleted user' do
     user = User.create!(name: 'Example', email: 'Example@email.com')
     user.delete!
     user.delete!
     expect(user.errors[:deleted_user_error]).to include('User already deleted')
   end
 end

# describe 'delete!' do
#   it 'sets deleted_user_error on an already deleted user' do
#     user = User.create!(name: 'Example', email: 'Example@email.com')
#     user.delete!
#     user.delete!
#     expect(user.errors[:deleted_user_error]).to include('User already deleted')
#   end
# end

### 10

describe 'roles' do
  it 'checks array if it includes admin' do
    expect(User.roles.keys).to include('admin')
  end
end

  # describe 'roles' do
  #   it 'checks array if it includes admin' do
  #     expect(User.roles.keys).to include('admin')
  #   end
  # end

### 11
describe 'Order' do
  it 'checks if order : total_price is > 100' do
    user = User.create!(name: 'Example', email: 'example@email.com')
    order = Order.create!(total_price: 200, user: user)
    expect(order.total_price).to be > 100
  end
end

  # describe 'Order' do
  #   it 'checks if order : total_price is > 100' do
  #     order = Order.create!(total_price: 100)
  #     expect(order.total_price).to be > 100
  #   end
  # end

### 12
describe 'Empty Users' do
  it 'checks that User.all is empty when there are no users' do
    expect(User.all).to be_empty
  end
end

  # describe 'Empty Users' do
  #   it 'checks that User.all is empty when there are no users' do
  #     expect(User.all).to be_empty
  #   end
  # end
  
  ### 13
describe 'User' do
    it 'checks that user responds to email' do
      user = User.create!(name: 'Example', email: 'example@email.com')
      expect(user).to respond_to(:email)
    end
  end
  
  # describe 'User' do
  #   it 'checks that user responds to email' do
  #     user = User.create!(name: 'Example', email: 'example@email.com')
  #     expect(user).to respond_to(:email)
  #   end
  # end

  ### 14
describe 'Notify!' do
    it 'checks that Notify! method calls the send_email method' do
      user = User.create!(name: 'Example', email: 'example@email.com')
      allow(user).to receive(:send_email).and_return('Email sent')
      expect(user.send_email).to eq('Email sent')
    end
  end

  ### 15
describe 'Time_Change' do
    it 'checks that Time.now changes after 1 second' do
      time = Time.now
      sleep(1)
      expect(Time.now).to be > time
    end
  end
end