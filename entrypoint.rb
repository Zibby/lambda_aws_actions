require 'json'
require 'digest/sha1' # For password
require_relative './lambda_handler.rb'

def start(event:, context:)
  response = LambdaHandler.new(event)
  { statusCode: response.statuscode, body: JSON.generate([response.body]) }
end
