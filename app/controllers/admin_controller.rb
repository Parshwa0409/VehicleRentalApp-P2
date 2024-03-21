class AdminController < ApplicationController
    # BEFORE ANY ACTION MAKE SURE THAT ADMIN IS SIGNED-IN
    before_action :authenticate_user!
    before_action :get_vehicle, only: [:update_vehicle, :edit_vehicle]

    def index
    end

    # CUSTOMER - CRUD
    def customers
        @all_users = User.where(:is_admin => false).paginate(page: params[:page])
    end

    def search_customer
        name = get_user_search_params[:name]
        email = get_user_search_params[:email]

        if name.empty? && email.empty?
            customers()
        elsif !name.empty? && !email.empty?
            @all_users =  User.where(is_admin:false, name:name, email:email).paginate(page: params[:page])
        elsif !email.empty?
            @all_users =  User.where(is_admin:false, email:email).paginate(page: params[:page])
        elsif !name.empty?
            @all_users =  User.where(is_admin:false, name:name).paginate(page: params[:page])
        end

        render :customers
    end

    # VEHICLE - CRUD
    def show_vehicles
        @all_vehicles = Vehicle.all.paginate(page: params[:page])
    end 

    def new_vehicle
        @vehicle = Vehicle.new
    end

    def create_vehicle
        vehicle = Vehicle.create(get_vehicle_params())
        if vehicle.save()
            redirect_to root_path
        else
            flash.now[:alert] = "ERROR: VEHICLE NOT ADDED TO THE DATABASE!!!\nPLEASE TRY AGAIN WITH VALID INFORMATION."
            render :new_vehicle
        end
    end

    def search_vehicle
        brand = get_vehicle_search_params[:brand]
        model = get_vehicle_search_params[:model]

        if brand.empty? && model.empty?
            show_vehicles()
        elsif !brand.empty? && !model.empty?
            @all_vehicles =  Vehicle.where(brand:brand, model:model).paginate(page: params[:page])
        elsif !model.empty?
            @all_vehicles =  Vehicle.where(model:model).paginate(page: params[:page])
        elsif !brand.empty?
            @all_vehicles =  Vehicle.where(brand:brand).paginate(page: params[:page])
        end

        render :show_vehicles
    end

    def edit_vehicle
    end

    def update_vehicle
        @vehicle.update(get_vehicle_params())

        if @vehicle.save
            redirect_to admin_vehicles_path
        else
            flash[:alert] = "ERROR IN UPDATION"
            render :edit_vehicle
        end
    end

    def destroy_vehicle
        id = get_vehicle_id[:id]
        vehicle = Vehicle.find_by(id: id)
        vehicle.destroy! if !vehicle.nil?

        redirect_to admin_vehicles_path
    end

    private

    def get_vehicle_params
        params.require(:vehicle).permit(:brand,:model,:year,:brand_logo,:price_per_day)
    end

    def get_vehicle_search_params
        return params.require(:search_vehicle).permit(:brand, :model)
    end

    def get_vehicle_id
        params.permit(:id)
    end

    def get_user_search_params
        return params.require(:search_customer).permit(:name, :email)
    end

    def get_vehicle
        @vehicle = Vehicle.find_by(id: params[:id])
    end

end