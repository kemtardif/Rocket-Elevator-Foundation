require 'rails_helper'
require 'spec_helper'

RSpec.describe "send text after update", type: :model do

    let(:elevator) { FactoryGirl.build_stubbed(:elevator)}
    it "send a text" do

        TwilioTextMessenger.any_instance.should_receive(:call)

        elevator.status = "Intervention"
        elevator.run_callbacks :update

        message = "The Elevator with id '1004', in building with id '1001' needs to be repaired by 'Jimmy'. His phone number is '111-111-1111'"

        expect(TwilioTextMessenger.new(message)).to be_present



    end
end