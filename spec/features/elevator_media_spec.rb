require 'spec_helper'
require 'rails_helper'
require 'ElevatorMedia/elevator_media'

#### Tests for ElevatorMedia API calls #####################

RSpec.describe ElevatorMedia, type: :module do

    describe ".Temperature" do
       let(:temperature) {ElevatorMedia.Temperature}
       let(:uri) { URI("http://api.openweathermap.org/data/2.5/weather?appid=#{ENV['WEATHER_APIKEY']}&q=montreal,ca&units=metric")}

       #### We first test if the api call respond with the right status and a not-empty body

        it "return a valid HTTP connection " do
            response = Net::HTTP.get_response(uri)
            expect(response).to be_a_kind_of(Net::HTTPOK)
            expect(response.body).not_to eq nil
        end

        #### We then check if the method return the right string

        it "return a valid string" do
            expect(temperature).to eq "<div> It is currently -0.13°C in Montreal, and it feels like 0°C!</div>"
        end 
    end
    
    describe ".News" do
        let(:news) {ElevatorMedia.News}
        let(:uri) { URI("http://newsapi.org/v2/everything?domains=wsj.com&apiKey=#{ENV['NEWS_APIKEY']}")}

        it "return a valid HTTP connection " do
            response = Net::HTTP.get_response(uri)
            expect(response).to be_a_kind_of(Net::HTTPOK)
            expect(response.body).not_to eq nil
        end
        it "return a valid string" do
            expect(news).to eq "<div> World News : The Wall Street Journal</div>"
        end 
    end

    describe ".Advertizing" do
        let(:ads) {ElevatorMedia.Advertizing}
        let(:uri) {  URI("https://api.rainforestapi.com/request?api_key=23083BF513D8427FA9FF2C7D58665AEF&type=bestsellers&url=https://www.amazon.com/Best-Sellers-Computers-Accessories-Memory-Cards/zgbs/pc/516866")}

        it "return a valid HTTP connection " do
            response = Net::HTTP.get_response(uri)
            expect(response).to be_a_kind_of(Net::HTTPOK)
            expect(response.body).not_to eq nil
        end
        it "return a valid string" do
            expect(ads).to eq "<img src=https://images-na.ssl-images-amazon.com/images/I/61wKZ4noXaL._AC_UL200_SR200,200_.jpg><div>Samsung Electronics EVO Select 256GB MicroSDXC UHS-I U3 100MB/s Full HD & 4K UHD Memory Card with Adapter (MB-ME256HA)</div><div>$24.99</div>"
        end 
    end
    #### Test if getContent method return the right string
    
    describe ".getContent" do 
        let(:content) {ElevatorMedia::Streamer.getContent}

        it "return a valid string" do
            expect(content). to eq("<div> It is currently -0.13°C in Montreal, and it feels like 0°C!</div><div> World News : The Wall Street Journal</div><img src=https://images-na.ssl-images-amazon.com/images/I/61wKZ4noXaL._AC_UL200_SR200,200_.jpg><div>Samsung Electronics EVO Select 256GB MicroSDXC UHS-I U3 100MB/s Full HD & 4K UHD Memory Card with Adapter (MB-ME256HA)</div><div>$24.99</div>") 
        end
    end


end


