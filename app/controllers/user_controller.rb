class UserController < ApplicationController
    # BEFORE ANY ACTION MAKE SURE THAT USER IS SIGNED-IN
    before_action :authenticate_user!

    # ALL AGREEMENTS - user/history
    def all_agreements
    end

    # ACTIVE AGREEMENT - user/active_agreement
    def active_agreement 
    end

    # PROFILE - user/profile
    def show
        @user = get_active_user()
    end
end
