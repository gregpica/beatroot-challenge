# README
This program was developed with Ruby on Rails and React.js. A Builder Design
Pattern and service objects were utilized to keep the Tracks API Controller as thin as possible. The 'nokogiri' gem was used to build XML documents. Tested using RSpec.
Blob objects and 'file-saver' were used in React to accomplish the XML file
download. Responsive design with Foundation.

$ bundle install
$ rails s

In separate terminal tab/window:
$ yarn install
$ yarn start

Navigate to http://localhost:3000/

To run test suite: $ bundle exec rspec

![Alt text](./app/assets/images/screenshot.jpg?raw=true)
