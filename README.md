# Rocket_Elevators : Quality and TDD

### Requirements:

-Implement and test (using Rspec) a new ElevatorMedia module with single class Streamer, having a method getContent that return a string of HTML media content.
-Implementation of tests for various section of the RoR app.
-Implement and test (using Nunit) of the ElevatorMedia namespace with single class Streamer, having a method getContent that return a string of HTML media content.

### Explanations for first requirement:

-The following gem were added (Faraday wasn't used) :

```ruby
gem 'faraday'
gem 'sinatra'
gem 'vcr'
gem 'factory_girl', '~> 4.9'
gem 'webmock'
gem 'rspec-rails'
```
- The lib/ElevatorMedia/ElevatorMedia.rb contain the module to be tested. Implemented there are three methods giving various content : Temperature, Advertizing and News. The three are expected to make api calls to various endpoint and return the needed string of information. The getContent method just concacenate the strings to return the HTML information.

-All tests are in the spec/features folder

-The api calls were stubbed in spec/spec_helper.rb using WebMock to return fixed content. For example :

```ruby
  	config.before(:each) do
	stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=7b69ac2d5782ffb6d49764e85311576a&q=montreal,ca&units=metric").
	with(
	headers: {
	'Accept'=>'*/*',
	'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
	'Host'=>'api.openweathermap.org',
	'User-Agent'=>'Ruby'
	}).
	to_return(status: 200, body: {"main":{"temp":-0.13,"feels_like":0}}.to_json, headers: {})
```
-The structure of the JSON response is such that no change should be made in production code when using real api calls.

-Takin as an example the test for Temperature, we first check that an api call is valid by returning a status OK and a non-empty body :

```ruby
        it "return a valid HTTP connection " do
            response = Net::HTTP.get_response(uri)
            expect(response).to be_a_kind_of(Net::HTTPOK)
            expect(response.body).not_to eq nil
        end
```

-The test passed, we can use this in production code. We then expect the method ElevatorMedia.Temperature to return the string we want :

```ruby
expect(temperature).to eq "<div> It is currently -0.13°C in Montreal, and it feels like 0°C!</div>"
```
-This is possible by JSON-parsing the request body and extract the right information, which is done in the method to make the test pass :

```ruby
        currentTemp = temperatures["main"]["temp"]
        feelsLike = temperatures["main"]["feels_like"]

        htmlTemp = "<div> It is currently #{currentTemp}°C in Montreal, and it feels like #{feelsLike}°C!</div>"

        return htmlTemp
```

-The logic for the two other calls is similar. We then test getContent to expect the right string.

### Explanations for second requirement:

-The four other tests are : 
	-Visiting the Intervention page as a logged-in user and check redirect if user is not employee. First, we test for user that is also employee, and expect current 
		path of "/interventions/new". We then test for a user that's not an employee and expect a redirect to the root path :
	
	```ruby
	@user = FactoryGirl.build_stubbed(:user, employee: nil)
        sign_in @user
        
        visit new_intervention_url
        expect(current_path).to eq root_path   
	```
	
	-We test the create intervention path : we first skip authentification (this is not what is tested here) and make a post request with the required parameters to the 			create path of the interventions controller and expect Intervention.count +1 (intervention is created), expect a redirect and a flash notice :
	
	```ruby
	expect { post :create, params: valid_params }.to change(Intervention, :count).by(1)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to match("Your Intervention Request was succesfully sent!")
	```
	
	-We test a lead creation, but this time by visiting the root page and filling in the required  form fields. We again expect Lead.count +1, a redirect to the top of page 
		and a flash notice :
		
	```ruby
	expect {click_button "btnForm"}.to change(Lead, :count).by(1)

        expect(page).to have_content 'Message Sent!'
        expect(current_path).to eq "/home"
	```
	
	-Finally, we check the Twilio service to be called when an elevator is updated. At update, we expect The Twilio model to create an instance with the right message, 
		and make a stub of that instance and expect that the "call" method is...called :
		
	```ruby
	expect(TwilioTextMessenger).to receive(:new).with(message).and_return(twilio)
    	expect(twilio).to receive(:call)

    	elevator.run_callbacks :update
	```
	-Factory_girl was used to create stubs of all the required instances, thus not having to actually connect to the database. The factory AND the macro used for employee 			login are found in spec/support.
	
### Explanations for third requirement:

	-For ElevatorMedia in dotnet, we have to folders, one for the actual ElevatorMedia name space and one for tests. The logic is a bit different here :
		the streamer class as string attributes:
	```c#
		public string news {  get;  set;  }  
		public string advertizing {  get;  set;  }  
		public string temperature {  get;  set;  }
		public string content {  get;  set;  }  
	```
	-We call the three methods, which will set those attributes to the desired strings. Thos methods are called in GetContent, setting the attributes, and we then concanate and return. 
	- To test, we first mock the httpClient in the test setup :
	```c#
	    _streamer = new Streamer();
            _handler = new Mock<HttpMessageHandler>();
            _client = _handler.CreateClient();
	 ```
	 
	 -We then set the handle attribute to the api route to mock and the mock response. WE then call the api and check the status and expect non-empty request body :
	 ```c#
		_handler.SetupRequest(HttpMethod.Get, urlTemperature)
           .ReturnsResponse("{'main':{'temp':0,'feels_like':1}}");  
                    
            var response = _client.GetAsync(urlTemperature).Result;
            var content = response.Content.ReadAsStringAsync().Result;
            
            Assert.True(response.IsSuccessStatusCode);
            Assert.That( content, Is.Not.Empty);
	    ```
	   -We only check for a single route, since this is redundant and the code is exactly the same for the other routes. we then check that the methods setting the 		attributes to the right string :
	   ```c#
	    Assert.That( _streamer.news, Is.Not.Empty);
            Assert.AreEqual( "<div> World News : The Wall Street Journal</div>", _streamer.news );
        ```
	-Finally, we check that getContent return the right string, containing the right informations :
	```c#
		Assert.That( _streamer.content, Is.Not.Empty);
            Assert.IsTrue(_streamer.content.Contains(_streamer.temperature));
            Assert.IsTrue(_streamer.content.Contains(_streamer.news));
            Assert.IsTrue(_streamer.content.Contains(_streamer.advertizing));
	 ```   
		




## Developper
- Kem Tardif (Team Leader)
- Kem Tardif
-Kem tardif
-And also Kem Tardif.

