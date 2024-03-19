class Vehicle < ApplicationRecord
    has_many :rental_agreements, dependent: :destroy
    has_many :users, through: :rental_agreements

    has_one_attached :brand_logo

    before_create :valid_image

    def valid_image
        if !brand_logo.attached?
            errors.add(:base,:invalid,message:"YOU NEED TO ADD AN BRAND-LOGO TO THE VEHICLE !!!")
            throw(:abort)
        end
    end
end
