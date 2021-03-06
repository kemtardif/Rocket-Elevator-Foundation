# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


require 'webmock/rspec'
require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'
include WebMock::API
require 'factory_girl'
#require 'capybara'


WebMock.disable_net_connect!(allow_localhost: true)
Capybara.app_host = 'localhost:3000'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
#Recaptcha.configuration.skip_verify_env.delete("test")
Capybara.app_host = 'localhost:3000'


#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL
  config.include ControllerMacros, :type => :request


  ############ LIST OF THE VARIOUS STUBS NEEDED TO MAKE THE REQUIRED TESTS


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

    stub_request(:get, "http://newsapi.org/v2/everything?apiKey=4e1b093a661546c7896c56b25c4baedd&domains=wsj.com").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'Host'=>'newsapi.org',
     'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: {
      "articles": [
                    {
                        "description": "The Wall Street Journal"
                    }
                  ]}.to_json, headers: {})

    stub_request(:get, "https://api.rainforestapi.com/request?api_key=23083BF513D8427FA9FF2C7D58665AEF&type=bestsellers&url=https://www.amazon.com/Best-Sellers-Computers-Accessories-Memory-Cards/zgbs/pc/516866").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Host'=>'api.rainforestapi.com',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: {
      "bestsellers": [
                    {
                      "title": "Samsung Electronics EVO Select 256GB MicroSDXC UHS-I U3 100MB/s Full HD & 4K UHD Memory Card with Adapter (MB-ME256HA)",
                      "image": "https://images-na.ssl-images-amazon.com/images/I/61wKZ4noXaL._AC_UL200_SR200,200_.jpg",
                      "price_lower": {
                          "raw": "$24.99"
                      }
                    }
                  ]}.to_json, headers: {})
    
    stub_request(:post, "https://superkem.zendesk.com/api/v2/tickets").
    with(
      body: "{\"ticket\":{\"subject\":\"Intervention required by Bob the Builder\",\"comment\":{\"body\":\"The Employee with ID 1 sent an intervention request for the company 'Rosenbaum-Harber'.\\n\\t\\tThey is an issue with building 2. Description of the request for intervention: Hello World.They mentionned the battery with ID 3.\\n\\t\\t\\tThe column with ID 4 was specified.\\n\\t\\t\\tThe elevator with ID 5 was selected.\\n\\t\\t\\tThe employee with ID  must be contacted.\\n\\t\\t\\tPlease follow-up with the person in charge. Thank you.\"},\"type\":\"problem\"}}",
      headers: {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>'Basic dGFyZGlmLmtyZW1saW5AZ21haWwuY29tL3Rva2VuOjlUbGlpNTg4ZGlpVFlDc0VyQWp2dlRxZVU1eVJmSENlcDNyRGJMc0k=',
      'Content-Type'=>'application/json',
      'User-Agent'=>'ZendeskAPI Ruby 1.28.0'
      }).
    to_return(status: 200, body: "", headers: {})

    stub_request(:get, "https://www.recaptcha.net/recaptcha/api/siteverify?remoteip=127.0.0.1&response=%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20&secret=6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: "", headers: {})

    stub_request(:post, "https://superkem.zendesk.com/api/v2/tickets").
    with(
      body: "{\"ticket\":{\"subject\":\"name from compagny\",\"comment\":{\"body\":\"The contact name from company compagny can be reached at email  abc@abc.com and at phone number .  has a project named project which would require contribution from Rocket Elevators.\\n Project description: description\\nAttached Message: message\"}}}",
      headers: {
     'Accept'=>'application/json',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'Authorization'=>'Basic dGFyZGlmLmtyZW1saW5AZ21haWwuY29tL3Rva2VuOjlUbGlpNTg4ZGlpVFlDc0VyQWp2dlRxZVU1eVJmSENlcDNyRGJMc0k=',
     'Content-Type'=>'application/json',
     'User-Agent'=>'ZendeskAPI Ruby 1.28.0'
      }).
    to_return(status: 200, body: "", headers: {})

    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
  with(
    body: "{\"from\":{\"email\":\"tardif.kremlin@gmail.com\"},\"personalizations\":[{\"to\":[{\"email\":\"abc@abc.com\"}],\"dynamic_template_data\":{\"fullName\":\"name\",\"projectName\":\"project\"}}],\"template_id\":\"d-25e02690608041c3b521a2dc34f072da\"}",
    headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer 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',
          'Content-Type'=>'application/json',
          'User-Agent'=>'sendgrid/6.3.7;ruby'
    }).
  to_return(status: 200, body: "", headers: {})

  stub_request(:post, "https://hooks.slack.com/services/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").
  with(
    body: {"payload"=>"{\"text\":\"The Elevator with id '1004' With serial number '' change status from 'status' to 'Intervention'\"}"},
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'Content-Type'=>'application/x-www-form-urlencoded',
   'User-Agent'=>'Ruby'
    }).
  to_return(status: 200, body: "", headers: {})

  stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/AC434e0528909bdfcc88f86f568eb71098/Messages.json").
  with(
    body: {"Body"=>"The Elevator with id '1004', in building with id '1001' needs to be repaired by 'Jimmy'. His phone number is '111-111-1111'", "From"=>"+17657198971", "To"=>"+15819831152"},
    headers: {
   'Accept'=>'application/json',
   'Accept-Charset'=>'utf-8',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'Authorization'=>'Basic QUM0MzRlMDUyODkwOWJkZmNjODhmODZmNTY4ZWI3MTA5ODoyZGZhYTUwNTE0ZGE0NjQyMmUyMzIzYTg2YjUxODRlNw==',
   'Content-Type'=>'application/x-www-form-urlencoded',
   'User-Agent'=>'twilio-ruby/5.42.0 (ruby/x86_64-linux 2.6.5-p114)'
    }).
  to_return(status: 200, body: "", headers: {})

  stub_request(:post, "https://hooks.slack.com/services/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").
  with(
    body: {"payload"=>"{\"text\":\"The Elevator with id '' With serial number '' change status from '' to 'Intervention'\"}"},
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'Content-Type'=>'application/x-www-form-urlencoded',
   'User-Agent'=>'Ruby'
    }).
  to_return(status: 200, body: "", headers: {})

  stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/AC434e0528909bdfcc88f86f568eb71098/Messages.json").
  with(
    body: {"Body"=>"The Elevator with id '', in building with id '' needs to be repaired by ''. His phone number is ''", "From"=>"+17657198971", "To"=>"+15819831152"},
    headers: {
   'Accept'=>'application/json',
   'Accept-Charset'=>'utf-8',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'Authorization'=>'Basic QUM0MzRlMDUyODkwOWJkZmNjODhmODZmNTY4ZWI3MTA5ODoyZGZhYTUwNTE0ZGE0NjQyMmUyMzIzYTg2YjUxODRlNw==',
   'Content-Type'=>'application/x-www-form-urlencoded',
   'User-Agent'=>'twilio-ruby/5.42.0 (ruby/x86_64-linux 2.6.5-p114)'
    }).
  to_return(status: 200, body: "", headers: {})


  end

  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::TestHelpers, :type => :controller
 


  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
