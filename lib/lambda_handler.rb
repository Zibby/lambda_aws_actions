require_relative 'ec2'
require_relative 'rds'
require_relative 'lambda_logger'

# Parent class for everything
class LambdaHandler
  include Ec2Process
  include RdsProcess
  include LoggerCloudWatch

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
    ll "processing event #{@action}"
    send(@action) # calls action against self
  end

  def load_from_headers(event)
    ll 'loading from headers'
    @headers = event['headers']
    @action = @headers['action'] || 'list_actions'
    @password = @headers['password']
    @server = @headers['server_id'] || nil
    @db_inst = @headers['database'] || nil
  end

  def check_password
    ll 'checking password'
    return true if Digest::SHA1.hexdigest(@password.to_s) == ENV['APIKEY']

    ll('invalid password', 'error')
    @body = 'invalid password'
    @statuscode = 404
  end

  def list_actions
    ll 'returning a list of actions to user'
    actions = 'server_status, teapot, database_address'
    @body = "You need to choose an action: (#{actions})"
    @statuscode = 200
  end

  def teapot
    ll 'have a brew'
    @body = 'short and stout'
    @statuscode = 418
  end
end
