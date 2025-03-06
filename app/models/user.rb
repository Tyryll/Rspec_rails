class User < ApplicationRecord
    has_many :orders, dependent: :destroy  # User has many orders
    enum :role, { user: 0, admin: 1 }  # Define roles

    def activate!
        update(active: true)
    end

    def greet
        "Hello, #{name}"
    end

    def admin?
        role == 'admin'
      end
end
