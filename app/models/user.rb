class User < ApplicationRecord
    has_secure_password

    def is_admin?
        false
    end
end
