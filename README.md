# Rocket_Elevators_CONSOLIDATION_WEEK

### Requirements:

-Making sure all prior services are working.
-Implementation of a new table "interventions" in MYSQL database and a new form page for employees to request new Interventions. A zendesk ticket is sent at request.
-Populate the database with new interventions
-Creaing an REST api with with the start and end date of specific interventions can be changed.

-MSQL db : kemtardifMSQL
-PSQL db : kemtardifPSQL

https://kemverynice.com/

### Explanations for first requirement:

-To access the admin section as...an admin! Use kem@tardif.com with password. The admin can access all tables, but cannot request an intervention. 
-All employees in the list Codeboxx gave use has access to the backdoor, with limited informations on the various tables. They can access
the intervention page, which become visible in the admin drop-down menu once you're logged in.

-To login into the superkem.zendesk.com workspace and access the leads, quotes and interventions ticket, use the credentials "tardif.kremlin@gmail.com", 
with password "Poplokov66".

-The Dropbox credentials are "tardif.kemlin@gmail.com" (NOTE THE MISSING "R"), with the same password as for Zendesk. Yes, I made two email accounts, because I 
enjoy wasting my time.

-Mathieu's number is set for Twilio API and the slack channel is the same as last week (as requested).


### Gems used:

```ruby 
No additional gem were used.
```

### Explanations for second requirement:

- The intervention table and the various foreign key relations are specified in a single migration, with various belong_to and has_many in the appropriate models :

```ruby

  def change
    create_table :interventions do |t|
      t.date       :startDateIntervention
      t.date       :endDateIntervention
      t.string         :result, :default => "Incomplete"
      t.string         :report
      t.string         :status, :default => "Pending"

    end
    add_reference :interventions, :author, index: true
    add_foreign_key :interventions, :employees, column: :author_id
    add_reference :interventions, :customer, foreign_key: true
    add_reference :interventions, :building, foreign_key: true
    add_reference :interventions, :battery, foreign_key: true
    add_reference :interventions, :column, foreign_key: true
    add_reference :interventions, :elevator, foreign_key: true
    add_reference :interventions, :employee, foreign_key: true

  end
```

```ruby
class Intervention < ApplicationRecord
    belongs_to :customer
    belongs_to :building
    belongs_to :battery, :optional => true
    belongs_to :column, :optional => true
    belongs_to :elevator, :optional => true
    
    belongs_to :author, class_name: "Employee", :foreign_key => 'author_id'
    belongs_to :employee, :optional => true, :foreign_key => 'employee_id'

end
```

-Both the html and js script are contained in the same html.erb file in views/interventions/new.html.erb. Instead of multiple ajax calls,  there's a single "ajax call function to which the various form fields ids are passed. Only a single choice can be made between battery, column and elevator and that choice persist in the database. The endpoint for the call in the intervention controller is search, to which is passed the form field id's and "type", selecting an appropriate responde and populating the drop-down menus :

```ruby
            if params["type"] == "building"
                @elements = Customer.find(params[:itemId]).buildings
            elsif params["type"] == "battery"
                @elements = Building.find(params[:itemId]).batteries
            elsif params["type"] == "column"
                @elements = Battery.find(params[:itemId]).columns
            elsif params["type"] == "elevator"
                @elements = Column.find(params[:itemId]).elevators
            end
```

-The "definition" method is specific to each models and is just a way to have nice input values in the drop-down, instead of only ids. It return a string and make send back an array of strings to the front end to name the elements in the drop-down:

For example, in the battery model :

```ruby
    def definition
        "(ID: " + "#{self.id}) " + self.cert_ope
    end
```

-In the intervention controller:

```ruby
        for element in @elements
            @list << element.definition
        end
```
-And finally in the javascript:

```javascript

 $("#" + element +"_id").append('<option value="' + elements[i]["id"] + '">' + list[i] + '</option>');
 ```
  
  -When the request is sent, a zenDesk problem ticket is sent to the above account. It contains only the relevant informations and is made interactive in the ticket_helper.rb file contained in app/helpers i.e. no mention of column if no column is selected :
  
  ```ruby
  		if params[:battery_id] != ""
			battery = "They mentionned the battery with ID #{params[:battery_id]}.
			"
			comment << battery
		end
		if params[:column_id] != ""
			column = "The column with ID #{params[:column_id]} was specified.
			"
			comment << column
		end
		if params[:elevator_id] != ""
			elevator = "The elevator with ID #{params[:elevator_id]} was selected.
			"
			comment << elevator
		end
		if params[:employee_id] != ""
			employee = "The employee with ID #{params[:employee_id]} must be contacted.
			"
			comment << employee
		end
  ```
  
  ### Gems used:

```ruby 
 gem 'bootstrap_form' (only gem used in this project)
```
  
  ### Explanations for third requirement:
  
 -First lines of seed.rb and very much self-explanatory. When a customer is created, we create an intervention and "attach" it, with random id's for the author and employee :
 
 ```ruby
 inter_ = create_intervention()
        customer_.interventions << inter_
        inter_.author = Employee.find(random)
        inter_.employee = Employee.find(random2)



        lead_ = lead_create(department)
        customer_.lead = lead_
        
        1.upto(rand(1..3)) do |bu|
            building_ = building_create(bu)
            customer_.buildings << building_


            building_.interventions << inter_
            customer_.interventions << inter_

 ```
 
 ### Explanation for fourth requirements:
 
 -Repo : https://github.com/kemtardif/Rocket_Elevators_Foundation_RESTAPI
 -The readme on this repo is not up-to-date. All new informations are HERE.
 -REST api url : https://rocket-elevators-foundation-restapi.azurewebsites.net
 -API routes:
 
 GET: https://rocket-elevators-foundation-restapi.azurewebsites.net/pendingRequests => return pending requests with no start date
GET: https://rocket-elevators-foundation-restapi.azurewebsites.net/inProgressRequests => return requests with start date but no end date
GET: https://rocket-elevators-foundation-restapi.azurewebsites.net/completedRequests => return requests with start and end date (Completed)

PUT https://rocket-elevators-foundation-restapi.azurewebsites.net/api/interventions/endIntervention/2 => add end date and change status to "Completed
PUT https://rocket-elevators-foundation-restapi.azurewebsites.net/api/interventions/startIntervention/2 => add start date and change status to "Inprogress"

-NOTE that the first put will return not found (404) if the request is made on interventions already done or not started yet (as measure of security)
-NOTE that the second put will return not found (404) on interventions already started or done (as measure of security).

-No parameters are sent for the requests.

-THe relevant part in the code are the intervention model containing the attributes, and the controller with the various end points, similar to those we did last week:

``c#
        [HttpPut("/endIntervention/{id}")]
        public async Task<ActionResult<Intervention>> endIntervention(long Id)
        {
            var toUpdate = _context.interventions.FirstOrDefault(u => u.id == Id);

            if (toUpdate.startDateIntervention != null &&  toUpdate.endDateIntervention == null){
                toUpdate.endDateIntervention =  DateTime.Now;
                toUpdate.status = "Completed";

            }else{

                return NotFound();
            }


            _context.interventions.Update(toUpdate);
            await  _context.SaveChangesAsync();


            return  toUpdate;
        }
```

-You can import the postman library at : https://www.getpostman.com/collections/50e5d7319703673f4583


## Developper
- Kem Tardif (Team Leader)
- Kem Tardif
-Kem tardif
-And also Kem Tardif.

