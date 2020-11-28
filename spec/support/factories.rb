require 'factory_girl'


FactoryGirl.define do
    factory :intervention do |f|
        f.author_id 1
        f.customer_id 2
        f.building_id 3
        f.report "hello"

    end
    factory :employee do |f|
        f.id 2
        f.first_name "Bob"
        f.last_name "the Builder"
       # f.user_id 1
       # f.user FactoryGirl.build_stubbed(:user)
    end


    factory :user do |f|
        f.id 1
        f.email "aaa@bbb.com"
        f.password "password"
        f.employee FactoryGirl.build_stubbed(:employee)
        
    end

    factory :building do |f|
        f.tect_contact_name "Jimmy"
        f.tect_contact_phone "111-111-1111"
    end

    factory :battery do |f|
        f.building FactoryGirl.build_stubbed(:building)
    end

    factory :column do |f|
        f.battery FactoryGirl.build_stubbed(:battery)
    end

    factory :elevator do |f|
        f.column FactoryGirl.build_stubbed(:column)
        f.status "status"
    end
end

