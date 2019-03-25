require_relative './ec2.rb'
require_relative './rds.rb'

# Parent class for everything
class LambdaHandler
  include Ec2Process
  include RdsProcess

  attr_accessor :body,
                :statuscode

  def initialize(event)
    @should_exit = false
    @body = 'Nothing Done - Uknown Error'
    @statuscode = 500
    load_from_headers(event)
    check_password
    return if @should_exit

    process_event
  end

  def process_event
    send(@action) # calls action against self
  end

  def load_from_headers(event)
    @headers = event['headers']
    @action = @headers['action'] || 'list_actions'
    @password = @headers['password']
    @server = @headers['server_id'] || nil
    @db_inst = @headers['database'] || nil
  end

  def check_password
    return if Digest::SHA1.hexdigest(@password.to_s) == ENV['APIKEY']

    @body = 'invalid password'
    @statuscode = 404
  end

  def list_actions
    @body = 'You need to choose an action: (server_status, teapot, database_address)'
    @statuscode = 200
  end

  def teapot
    @body = 'short and stout'
    @statuscode = 418
  end
end
