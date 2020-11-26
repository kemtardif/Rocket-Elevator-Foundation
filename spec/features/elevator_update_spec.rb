require 'rails_helper'
require 'spec_helper'

## TEST FOR SENDING MESSAGE AFTER ELEVATOR STATUS IS UPDATED

RSpec.describe "send text after update", type: :model do

    #####Define various instances that we need to test

    let(:message) {"The Elevator with id '1004', in building with id '1001' needs to be repaired by 'Jimmy'. His phone number is '111-111-1111'"}
    let(:elevator) {FactoryGirl.build_stubbed(:elevator) }
    let(:twilio) {instance_double(TwilioTextMessenger, message: message)}

    before { elevator.status = "Intervention" }

    before do
        allow(twilio).to receive(:call)
    end
 
    it "send a text" do

    ##Expecting class the create new instance with the right message
    ## Expecting that instance call method

    expect(TwilioTextMessenger).to receive(:new).with(message).and_return(twilio)
    expect(twilio).to receive(:call)

    elevator.run_callbacks :update

    end
end