# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# This will add tasks to your deploy process
require "capistrano/rails"
require "capistrano/puma"
require 'capistrano/rvm'
require 'capistrano/postgresql'
require "capistrano/bundler"

# Load the SCM plugin appropriate to your project:
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
