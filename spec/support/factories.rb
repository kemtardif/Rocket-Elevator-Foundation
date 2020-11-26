require 'factory_girl'

FactoryGirl.define do
    factory :intervention do |f|
        f.author_id 1
        f.customer_id 2
        f.building_id 3
        f.report "hello"

    end

    factory :user do |f|
        f.id 1
        f.email "aaa@bbb.com"
        f.password "password"
        
    end

    factory :employee do |f|
        f.id 2
        f.first_name "Bob"
        f.last_name "the Builder"
        f.user_id 1
        f.user FactoryGirl.build_stubbed(:user)
    end
end
