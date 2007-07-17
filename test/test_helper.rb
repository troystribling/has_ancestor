# Load the environment
ENV['RAILS_ENV'] ||= 'test'
require "#{File.dirname(__FILE__)}/rails_root/config/environment.rb"
require "#{File.dirname(__FILE__)}/unit/test_create_model_helper"

# Load the testing framework
require 'test_help'
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

class Test::Unit::TestCase #:nodoc:
  def create_fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
  end
  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
#  #### load model files
  def setup
    @model = File.open(File.dirname(__FILE__) + '/fixtures/test_model.yml') {|yf| YAML::load(yf)}
  end
  
end