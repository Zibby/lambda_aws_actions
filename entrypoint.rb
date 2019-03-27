require 'json'
require 'digest/sha1' # For password
require 'logger'
require_relative './lambda_handler.rb'

LOG = Logger.new(STDOUT)

def start(event:, context:)
  response = LambdaHandler.new(event)
  Log.info "Started #{context.function_name}"
  { statusCode: response.statuscode, body: JSON.generate([response.body]) }
end
