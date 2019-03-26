#!/usr/bin/env ruby
require 'test/unit'
require 'yaml'

require_relative '../entrypoint'
configfile = 'testing.yml'
config = YAML.load_file(configfile)

ENV['APIKEY'] = config['APIKEY']
ENV['AWSKEY'] = config['AWSKEY']
ENV['AWSSEC'] = config['AWSSEC']

SERVER = config['SERVER']
DATABASE = config['DATABASE']
PASSWORD = config['PASSWORD']

# Tests use AWS calls
class LambdaTest < Test::Unit::TestCase
  def test_teapot
    event = {}
    event['headers'] = {}
    event['headers']['password'] = PASSWORD
    event['headers']['action'] = 'teapot'
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 418
  end

  def test_ec2_status
    event = {}
    event['headers'] = {}
    event['headers']['password'] = PASSWORD
    event['headers']['action'] = 'server_status'
    event['headers']['server_id'] = SERVER
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 200
    assert_match 'Server is:', response.body
  end

  def test_database_url
    event = {}
    event['headers'] = {}
    event['headers']['password'] = PASSWORD
    event['headers']['action'] = 'database_address'
    event['headers']['server_id'] = DATABASE
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 200
    assert_match(/\.rds.amazonaws.com/, response.body)
  end

  def test_start_server
    event = {}
    event['headers'] = {}
    event['headers']['password'] = PASSWORD
    event['headers']['action'] = 'start_server'
    event['headers']['server_id'] = SERVER
    response = LambdaHandler.new(event)
    assert_equal response.statuscode, 200
    assert_match(/Server changed from/, response.body)
  end
end
