# Longbox

:warning: **This code is a work in progress. It should be considered unstable, untested, and unsupported.** :warning:

## Overview

This is a simple comic book collection tracking app that allows a user to organize their collection and avoid purchasing duplicates. Future idaes and enhancements include:
  
  * View common writers and artists in their collection.
  * Graph purchases and spending over time.
  * Track a pull list of upcoming releases. 

## Prerequisites

  * Ruby 2.3.x
  * SQLite 3
  * Bundler
   
## Setting up the REST API

  * Run `bundle install` at the root folder to download dependencies.
  * Run `bundle exec rackup -p 8000` in the root folder.
  * Navigate to http://localhost:3000 in your favourite browser.

## Running the test suite

  * Run `bundle install` at the root folder to download dependencies.
  * Run `bundle exec rspec` to execute the test suite.
