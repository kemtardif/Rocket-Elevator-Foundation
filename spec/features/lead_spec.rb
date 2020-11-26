require 'rails_helper'
require 'spec_helper'

RSpec.describe "creating leads", type: :feature do

    it "create lead succesfully" do
        visit root_url   

        fill_in "contact:company", with: "compagny"
        fill_in "contact:name", with: "name"
        fill_in "contact:email", with: "abc@abc.com"
        fill_in "contact:project", with: "project"
        fill_in "contact:description", with: "description"
        fill_in "contact:message", with: "message"

        expect {click_button "btnForm"}.to change(Lead, :count).by(1)
        expect(page).to have_content 'Message Sent!'
        expect(current_path).to eq "/home"

    end
end

