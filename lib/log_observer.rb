# Required Libs
require 'logger'
require 'observer'

# Observer Definition
class LogObserver
  
  # Initializes observing
  def initialize(logger_to_observe, logger = nil)
    logger ||= Logger.new(Merb.root/'log'/"#{Merb.environment}.log")
    @logger = logger
    logger_to_observe.add_observer(self)
  end
  
  # Called by the observed objects
  def update(level, msg)
    # msg << "\n" unless msg[-1] == ?\n
    @logger.add(Logger.const_get(level.upcase.to_sym), parse(msg))
  end
  
  # Transform messages into alternate formats depending on formats
  # (used for making difficult formats easier to parse)
  def parse(msg)
    msg
  end
  
end

# Modify Merb::Logger to notify observers
require 'merb-core/logger'
module Merb
  class Logger
    include Observable
    
    # Generate the logging methods for Merb.logger for each log level.
    Levels.each_pair do |name, number|
      class_eval <<-LEVELMETHODS, __FILE__, __LINE__
      
      def #{name}(message = nil)
        self << message && changed if #{number} >= level
        notify_observers("#{name}", message)
        self
      end
      
      def #{name}!(message = nil)
        self << message && changed if #{number} >= level
        notify_observers("#{name}", message)
        flush if #{number} >= level
        self
      end
      
      def #{name}?
        #{number} >= level
      end
      LEVELMETHODS
    end
  end
end

# Begin Observing
logger = Logger.new(Merb.root/'log'/"#{Merb.environment}.log")
logger.level = Logger::DEBUG
logger.formatter = proc{|s,t,p,m|"%5s [%s] (%s) %s :: %s\n" % [s, t.strftime("%Y-%m-%d %H:%M:%S"), $$, p, m]}
LogObserver.new(Merb.logger, logger)
