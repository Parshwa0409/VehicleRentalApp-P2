class UserController < ApplicationController
    # BEFORE ANY ACTION MAKE SURE THAT USER IS SIGNED-IN
    before_action :authenticate_user!

    # USER CAN RENT or NOT
    def can_rent
        user = get_active_user()
        if user.is_renting?
            flash[:alert] = "At this moment, you are renting a vehicle. You cannot rent more than one vehicle at a time."
            redirect_to vehicles_path
        else
            session[:v_id] = params[:id]
            redirect_to new_agreement_path
        end
    end

    # ACTIVE AGREEMENT
    def active
        user = get_active_user()
        active_agreement = user.rental_agreements.find_by(acitve: true)
        @vehicle =  active_agreement.vehicle if !(active_agreement.nil?)
    end

    # END ACTIVE AGREEMENT
    def return_car
        user = get_active_user()
        active_agreement = user.rental_agreements.find_by(acitve: true)
        vehicle =  active_agreement.vehicle

        vehicle.update_column(:is_rented, false)
        user.update_column(:is_renting, false)
        active_agreement.update_column(:acitve, false)

        redirect_to root_path
    end

    # HISTORY
    def all_agreements
        user = get_active_user()
        @history = user.rental_agreements if !user.nil?
    end

    # PROFILE - user/profile
    def show
        @user = get_active_user()
    end
end
