# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Squash::Application.load_tasks

require "dropbox-api"
require "dropbox-api/tasks"
Dropbox::API::Tasks.install
