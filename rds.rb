require 'aws-sdk-rds'

# Handles RDS instances
module RdsProcess
  attr_accessor :rdsclient

  def connect_to_rds!
    @rdsclient = Aws::RDS::Client.new(
      region: 'eu-west-1',
      access_key_id: ENV['AWSKEY'],
      secret_access_key: ENV['AWSSEC']
    )
  end

  def database_address
    connect_to_rds! if @rdsclient.nil?
    insts = @rdsclient.describe_db_instances(db_instance_identifier: @db_inst)
    instance = insts.first.db_instances.first
    @body = instance.endpoint.address
    @statuscode = 200
  end

  def restart_database
    connect_to_rds! if @rdsclient.nil?
    @rdsclient.reboot_db_instance(db_instance_identifier: @db_inst)
    @body = "Rebooting database: #{@db_inst}"
    @statuscode = 200
  end
end
