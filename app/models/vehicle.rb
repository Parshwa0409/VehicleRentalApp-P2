class Vehicle < ApplicationRecord
    self.per_page = 7 # pagination

    has_many :rental_agreements, dependent: :destroy
    has_many :users, through: :rental_agreements

    has_one_attached :brand_logo

    validates :brand, presence: true
    validates :model, presence: true
    validates :year, presence: true
    validates :price_per_day, presence: true

    before_create :valid_image

    private
    def valid_image
        if !brand_logo.attached?
            errors.add(:base,:invalid,message:"YOU NEED TO ADD AN BRAND-LOGO TO THE VEHICLE !!!")
            throw(:abort)
        end
    end
end
