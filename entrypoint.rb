require 'json'
require 'digest/sha1' # For password
require_relative 'lib/lambda_handler'

def start(event:, context:)
  response = LambdaHandler.new(event)
  puts "INFO -- Started #{context.function_name}"
  { statusCode: response.statuscode, body: JSON.generate([response.body]) }
end
