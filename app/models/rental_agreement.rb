class RentalAgreement < ApplicationRecord

    # validations
    validates :start_date, presence: true
    validates :end_date, presence: true
    
    before_create  do |agreement|
        if self.end_date < self.start_date
            # errors.add(:attr, :type{invalid / blank}, :message)
            # if we add the attr_name we get it in the error-msg , so use :base
            errors.add(:base,:invalid, message:"Please ensure that the end date of the rental agreement is later than the start date. It is not possible to select an end date that is earlier than the start date")
            throw(:abort)
        end
    end

    # associations
    has_one :payment, dependent: :destroy
    
    belongs_to :user
    belongs_to :vehicle

end
