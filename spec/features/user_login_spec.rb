require 'spec_helper'
require 'rails_helper'


##### TESTING EMPLOYEE REDIRECT TO INTERVENTION PATH  ########

RSpec.describe InterventionsController, type: :request do

    
    it "get intervention route when user has employee" do
        ##We expect no redirect to home if user has employee (which it has by creation in factory)

        @user = FactoryGirl.build_stubbed(:user)
        sign_in @user

        visit new_intervention_url
        expect(current_path).to eq '/interventions/new'        
    end

    it "get root path when user has no employee" do
        ##We expect redirect to home if user has no employee 

        @user = FactoryGirl.build_stubbed(:user, employee: nil)
        sign_in @user
        
        visit new_intervention_url
        expect(current_path).to eq root_path        
    end
end
