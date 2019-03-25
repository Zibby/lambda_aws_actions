require 'test/unit'
require 'yaml'

require_relative '../entrypoint'
configfile = 'testing.yml'
config = YAML.load_file(configfile)

ENV['APIKEY'] = config['APIKEY']
ENV['AWSKEY'] = config['AWSKEY']
ENV['AWSSEC'] = config['AWSSEC']

# Tests use AWS calls
class LambdaTest < Test::Unit::TestCase
  def test_teapot
    event = {}
    event['headers'] = {}
    event['headers']['password'] = 'megapass'
    event['headers']['action'] = 'teapot'
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 418
  end

  def test_ec2_status
    event = {}
    event['headers'] = {}
    event['headers']['password'] = 'megapass'
    event['headers']['action'] = 'server_status'
    event['headers']['server_id'] = 'i-0646a0c567c9941c1'
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 200
    assert_match 'Server is:', response.body
  end

  def test_database_url
    event = {}
    event['headers'] = {}
    event['headers']['password'] = 'megapass'
    event['headers']['action'] = 'database_address'
    event['headers']['server_id'] = 'accor-hotels'
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 200
    assert_match(/\.rds.amazonaws.com/, response.body)
  end
end