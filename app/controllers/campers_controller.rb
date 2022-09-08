class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_message
    def index
        render json: Camper.all
    end
    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitiesSerializer
    end

    def create
        camper = Camper.create!(permitted_params)
        render json: camper, status: :created
    end

    private
    def permitted_params
        params.permit(:name, :age)
    end

    def record_not_found_message
        render json: {error: "Camper not found"}, status: :not_found
    end

    def record_invalid_message(exception)
        render json: {errors: exception.record.errors.full_message}, status: :unprocessable_entity
    end
end