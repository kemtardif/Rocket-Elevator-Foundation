
module ElevatorMedia

    class Streamer    
        def self.getContent  
            content = ElevatorMedia.Temperature
            content << ElevatorMedia.News
            content << ElevatorMedia.Advertizing
            
            return content
        end
    end


    def self.Temperature
        uri = URI("http://api.openweathermap.org/data/2.5/weather?appid=#{ENV['WEATHER_APIKEY']}&q=montreal,ca&units=metric")
        response = Net::HTTP.get_response(uri)

        temperatures =  JSON.parse response.body

        currentTemp = temperatures["main"]["temp"]
        feelsLike = temperatures["main"]["feels_like"]

        htmlTemp = "<div> It is currently #{currentTemp}°C in Montreal, and it feels like #{feelsLike}°C!</div>"

        return htmlTemp
    end

    def self.Advertizing

        uri = URI("https://api.rainforestapi.com/request?api_key=23083BF513D8427FA9FF2C7D58665AEF&type=bestsellers&url=https://www.amazon.com/Best-Sellers-Computers-Accessories-Memory-Cards/zgbs/pc/516866")
        response = Net::HTTP.get_response(uri)

        ads =  JSON.parse response.body

        image = ads["bestsellers"][0]["image"]
        title = ads["bestsellers"][0]["title"]
        price = ads["bestsellers"][0]["price_lower"]["raw"]

        htmlAd = "<img src=#{image}><div>#{title}</div><div>#{price}</div>"

        return htmlAd
    end


    def self.News

        uri = URI("http://newsapi.org/v2/everything?domains=wsj.com&apiKey=#{ENV['NEWS_APIKEY']}")
        response = Net::HTTP.get_response(uri)

        news = JSON.parse response.body

        htmlNews = "<div> World News : #{news["articles"][0]["description"]}</div>"

        return htmlNews
    end
end
