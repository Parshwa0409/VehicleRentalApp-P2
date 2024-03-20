class AdminController < ApplicationController
before_action :authenticate_user!

    def index
    end

    # VEHICLE - CRUD
    def show_vehicles
        @all_vehicles = Vehicle.all.paginate(page: params[:page])
    end 

    def new_vehicle

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
        brand = get_search_params[:brand]
        model = get_search_params[:model]

        if brand.empty? && model.empty?
            show_vehicles()
            # redirect_to admin_vehicles_path
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
        # @vehicle = Vehicle.find_by(id: session[:vehicle_id])
        p params[:id]
        # if @vehicle.present?
        #   @vehicle.update.update_column(:brand,params[:brand]) if params[:brand] !=""
        #   @vehicle.update.update_column(:model,params[:model]) if params[:model] != ""
        #   @vehicle.update.update_column(:year,params[:year]) if params[:year] !=""
        #   @vehicle.update.update_column(:price_per_day,params[:price_per_day]) if params[:price_per_day] !=""
        #   @vehicle.update.update_column(:brand_logo,params[:brand_logo]) if !params[:brand_logo].nil?
        # end
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

    def get_search_params
        return params.require(:search_vehicle).permit(:brand, :model)
    end

    def get_vehicle_id
        params.permit(:id)
    end

  end
  