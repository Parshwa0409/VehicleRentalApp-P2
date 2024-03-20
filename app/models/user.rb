class User < ApplicationRecord
  self.per_page = 7 # pagination

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  # validations of input's from the form
  validates :name, presence: true
  validates :address, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "THE EMAIL MUST BE VALID"}, uniqueness: true
  validates :phone_no, presence: true, format:{ with: /(\d{10})/, message: "PHONE NUMBER MUST HAVE 10 DIGITS"}, uniqueness:true
  validates :password, presence: true, format: {with: /.{8,}/, message: "THE PASSWORD MUST BE MINIMUM 8 CHARACTERS"}
  validates :password_confirmation, presence: true

  # associations
  has_many :rental_agreements, dependent: :destroy
  has_many :vehicles, through: :rental_agreements  
end
