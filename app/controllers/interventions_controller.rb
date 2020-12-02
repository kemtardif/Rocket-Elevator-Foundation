class InterventionsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_employee

    def new 

    end

    def check_employee

        return unless current_user.employee == nil
        redirect_to root_path, alert: 'You are not allowed to access this part of the site'
    end
    

    def create     
        @intervention = Intervention.new(params
        .permit(:name, 
                :customer_id, 
                :building_id, 
                :battery_id, 
                :column_id, :elevator_id, 
                :employee_id, 
                :report))

        @intervention.author_id = current_user.id


        if @intervention.save
            redirect_to root_path, notice: "Your Intervention Request was succesfully sent!"
            helpers.ticket_intervention(params
                                    .permit(:name, 
                                            :customer_id, 
                                            :building_id, 
                                            :battery_id, 
                                            :column_id, 
                                            :elevator_id, 
                                            :employee_id, 
                                            :report))
            else
            redirect_to new_intervention_path, alert: "There was an error sending your Intervention Request!"
        end   

    end
    
    def search

        @list = []
            if params["type"] == "building"
                @elements = Customer.find(params[:itemId]).buildings
            elsif params["type"] == "battery"
                @elements = Building.find(params[:itemId]).batteries
            elsif params["type"] == "column"
                @elements = Battery.find(params[:itemId]).columns
            elsif params["type"] == "elevator"
                @elements = Column.find(params[:itemId]).elevators
            end

        for element in @elements
            @list << element.definition
        end

        if request.xhr?
            respond_to do |format|
                format.json {
                    render json: {elements: @elements,
                                    list: @list}
                }
            end
        end
    end    
end
