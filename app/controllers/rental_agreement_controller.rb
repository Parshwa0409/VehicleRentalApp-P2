class RentalAgreementController < ApplicationController
    # DISPLAY NEW - AGREEMENT FORM
    def new
        @agreement = RentalAgreement.new()
        @payment = Payment.new()
    end

    # CREATE NEW AGREEMENT
    def create
        user = get_active_user()
        vehicle = get_vehicle(session[:v_id])

        data = get_params()
        start_date = data[:start_date].to_date()
        end_date = data[:end_date].to_date()
        cardholder_name = data[:cardholder_name]
        card_number = data[:card_number]
        cvv = data[:cvv]
        expiry_date = data[:expity_date].to_date()
        total_cost = (end_date - start_date).to_i() * vehicle.price_per_day


        @agreement = RentalAgreement.create(
        user:user, 
        vehicle:vehicle, 
        start_date:start_date, 
        end_date:end_date,
        total_cost:total_cost,
        acitve:true
        )

        if @agreement.save()
            @payment = @agreement.create_payment(
            cardholder_name:cardholder_name,
            card_number:card_number,
            cvv:cvv,
            expiry_date:expiry_date
            )

            if @payment.save()
                user.update_column(:is_renting, true)
                vehicle.update_column(:is_rented, true)
                redirect_to root_path
            else
                flash.now[:alert] = "Payment ERROR: Plese enter valid payment details!!!"
                @agreement.destroy if !(@agreement[:id].nil?)
                render :new
            end
        else
            render :new
        end
    end

    def detail
        @agreement = RentalAgreement.find_by(id: params[:id])
        @payment_details = @agreement.payment if !@agreement.nil?
    end

    private 
    def get_params
        return params.permit(:start_date,:end_date,:cardholder_name,:card_number,:cvv,:expity_date)
    end
end