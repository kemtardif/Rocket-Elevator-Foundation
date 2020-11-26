require 'rails_helper'
require 'spec_helper'

## TEST FOR SENDING MESSAGE AFTER ELEVATOR STATUS IS UPDATED

RSpec.describe "send text after update", type: :model do

    let(:elevator) { FactoryGirl.build_stubbed(:elevator)}

    it "send a text" do
        
        ### This check if any instance of the twilio service do it's "call method" during the test

        TwilioTextMessenger.any_instance.should_receive(:call)

        ### We change the status and apply the after_update callbach

        elevator.status = "Intervention"
        elevator.run_callbacks :update

        message = "The Elevator with id '1004', in building with id '1001' needs to be repaired by 'Jimmy'. His phone number is '111-111-1111'"
        
        ## We check if there's indeed an instance with the right message
        
        expect(TwilioTextMessenger.new(message)).to be_present



    end
end