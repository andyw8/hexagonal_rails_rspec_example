# README

[![Build Status](https://travis-ci.org/andyw8/hexagonal_rails_rspec_example.svg?branch=master)](https://travis-ci.org/andyw8/hexagonal_rails_rspec_example)

This is my attempt at implementing some of the ideas from [Hexagonal Rails](https://www.youtube.com/watch?v=CGN4RFkhH2M).

It includes full specs, and I've tried to document the non-obvious things which I learned during the process of working on this.

The files likely to be of interest are:

* /app/controllers/widgets_controller.rb
* /spec/app/controllers/widgets_controller_spec.rb

* /app/lib/widget_creator.rb
* /spec/app/lib/widget_creator.rb

* /spec/app/lib/widget_updater.rb
* /app/lib/widget_updater.rb

All the controller tests avoid hitting the database.

