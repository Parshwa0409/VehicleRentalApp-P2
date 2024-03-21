class VehicleController < ApplicationController
    # VEHICLES - /vehicles
    def show
        @all_vehicles = (Vehicle.where(:is_rented => false).order(:year)).paginate(page: params[:page])
    end
  
    def search_vehicle
        brand = get_vehicle_search_params[:brand]
        model = get_vehicle_search_params[:model]
        
        if brand.empty? && model.empty?
            show()
        elsif !brand.empty? && !model.empty?
            @all_vehicles =  Vehicle.where(brand:brand, model:model).paginate(page: params[:page])
        elsif !model.empty?
            @all_vehicles =  Vehicle.where(model:model).paginate(page: params[:page])
        elsif !brand.empty?
            @all_vehicles =  Vehicle.where(brand:brand).paginate(page: params[:page])
        end

        render :show
    end

    private

    def get_vehicle_search_params
        return params.require(:search_vehicle).permit(:brand, :model)
    end
end
