# Formats output for Cloudwatch
module LoggerCloudWatch
  def ll(message, level = 'info')
    puts "#{level.upcase} -- #{message}"
  end
end
