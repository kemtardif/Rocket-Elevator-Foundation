require 'spec_helper'
require 'rails_helper'
require 'factory_girl'

###TEST FOR INTERVENTION CREATION #######

RSpec.describe InterventionsController, type: :controller do

    ### We first stub an employee, which is needed to access the page

    let!(:user) {FactoryGirl.build_stubbed(:user)}
    
    #### Allow to bypass authentification process, which is not what we test

    before { allow(controller).to receive(:authenticate_user!).and_return(true) }
    before { allow(controller).to receive(:current_user) { user } }

    #### Mock intervention form

    let!(:valid_params) do
         {
                customer_id: 1,
                building_id: 2,
                battery_id: 3,
                column_id: 4,
                elevator_id: 5,
                report: "Hello World"
            }
        
    end

    it "create intervention succesfully" do

        ### We expect creation of an Intervention, a redirect and a flash notice
       
        expect { post :create, params: valid_params }.to change(Intervention, :count).by(1)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to match("Your Intervention Request was succesfully sent!")
    end
end


