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

  def start_server
    connect_to_ec2! if @ec2client.nil?
    state_change = @ec2client.start_instances(instance_ids: [@server])
    state_change = state_change.first.starting_instances.first
    old_state = state_change.previous_state.name
    new_state = state_change.current_state.name
    @body = "Server changed from #{old_state} to #{new_state}"
    @statuscode = 200
  end
end
