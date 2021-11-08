Hutch::Logging.logger = Rails.logger

unless Rails.env.test?
  client_logger = Logger.new('log/hutch.log')
  Hutch::Config.set(:client_logger, client_logger)
end
