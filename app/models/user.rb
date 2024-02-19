class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true,
                    length: {
                      maximum: 255
                    },
                    uniqueness: true,
                    format: {
                      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
                    }

  validates :password, presence: true, length: { minimum: 6 }

  before_validation {
    if email
      email.downcase!
    end

    email = ""
  }
  has_secure_password

end
