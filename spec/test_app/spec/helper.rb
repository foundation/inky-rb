# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require_relative "../config/environment.rb"
require 'capybara/rspec'
require 'capybara/rails'
require_relative '../../spec_helper.rb'
require 'slim'

Rails.backtrace_cleaner.remove_silencers!
RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = %i[should expect] }
  # config.infer_spec_type_from_file_location!
end
