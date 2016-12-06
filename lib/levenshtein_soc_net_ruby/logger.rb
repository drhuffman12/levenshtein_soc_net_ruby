require 'logger'
module LevenshteinSocNetRuby
  class Logger
    def initialize
      @log_path = "log/#{Time.now.strftime("%Y_%m_%d")}"
      @log_file = "/app_#{Time.now.strftime("%H-%M-%S")}.log"
      FileUtils.mkdir_p(@log_path)
    end

    def logger
      log = ::Logger.new(@log_path + @log_file)
      log.level = ::Logger::WARN
      log
    end
  end
end
