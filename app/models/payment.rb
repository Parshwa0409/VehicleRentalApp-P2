class Payment < ApplicationRecord
    validates :cardholder_name, presence: true
    validates :card_number, presence: true, format:{ with: /(\d{15,16})/, message: "CARD NUMBER IS INVALID"}
    validates :cvv, presence: true, format:{ with: /(\d{3})/, message: "CVV MUST HAVE 3 DIGITS"}
    validates :expiry_date, presence: true

    before_create  do |payment|
        if self.expiry_date < Date.current
            errors.add(:base,:invalid, message:"Apologies, it seems the card you provided has expired. Kindly proceed with a different card to complete the transaction")
            throw(:abort)
        end
    end

    # associations
    belongs_to :rental_agreement
end
