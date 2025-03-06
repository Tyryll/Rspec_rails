class User < ApplicationRecord
    has_many :orders, dependent: :destroy  # User has many orders

    enum :role, { user: 0, admin: 1 }  # Define roles

    def activate!
        update!(active: true)
    end

    def greet
        "Hello, #{name}"
    end

    def admin?
        role == "admin"
    end

    def delete!
        if deleted?
            errors.add(:deleted_user_error, "User already deleted")
        else
            update!(deleted_at: Time.now)
        end
    end

    def deleted?
        deleted_at.present?
    end

    def update_email!(new_email)
        update!(email: new_email)
    end

    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Welcome to Our App")
    end

    def send_email
        # Logic to send email
        'Email sent'
    end
end
