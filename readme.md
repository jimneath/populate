# Populate

Populates your database with lovely fake data automatically.

## Prequisites

Populate has only been tested with Ruby 1.9.3 and Rails 3.1+. As such, it probably won't work with anything else.

## Installation

    gem 'populate'
    
## Useage

    task :populate => :environment do
      populate User, 10..50
      populate Article, 100..500
    end
   
## Credits

Jim Neath