require 'aws-sdk-ec2'

# Handles EC2 instances
module Ec2Process
  attr_accessor :ec2client

  def connect_to_ec2!
    @ec2client = Aws::EC2::Client.new(
      region: 'eu-west-1',
      access_key_id: ENV['AWSKEY'],
      secret_access_key: ENV['AWSSEC']
    )
  end

  def server_status
    connect_to_ec2! if @ec2client.nil?
    instances = @ec2client.describe_instances(instance_ids: [@server]).first
    status = instances.reservations.first.instances.first.state.name
    @body = "Server is: #{status}"
    @statuscode = 200
  end
end
