class User < ApplicationRecord
    def activate!
        update(active: true)
    end

    def greet
        "Hello, #{name}"
    end
end
