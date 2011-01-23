# RailRoad - RoR diagrams generator
# http://railroad.rubyforge.org
#
# Copyright 2007-2008 - Javier Smaldone (http://www.smaldone.com.ar)
# See COPYING for more details

require 'ostruct'

# RailRoad command line options parser
class OptionsStruct < OpenStruct

  require 'optparse'

  def initialize
    init_options = { :join => false,
                     :root => '',
                     :verbose => false,
                     :model_dir => Dir.pwd }
    super(init_options)
  end # initialize

  def parse(args)
    @opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{APP_NAME} [options]"
      opts.separator ""
      opts.separator "Common options:"
      opts.on("-o", "--output FILE", "Write diagram to file FILE") do |f|
        self.output = f
      end
      opts.on("-r", "--root PATH", "Set PATH as the application root") do |r|
        self.root = r
      end
      opts.on("-m", "--model_dir PATH", "Set model PATH") do |m|
        self.model_dir = m
      end
      opts.on("-v", "--verbose", "Enable verbose output", 
              "  (produce messages to STDOUT)") do |v|
        self.verbose = v
      end
      opts.separator "Models diagram options:"
      opts.on("-j", "--join", "Concentrate edges") do |j|
        self.join = j
      end
      opts.separator ""
      opts.separator "Other options:"
      opts.on("-h", "--help", "Show this message") do
        STDOUT.print "#{opts}\n"
        exit
      end
    end # do

    begin
      @opt_parser.parse!(args)
    rescue OptionParser::AmbiguousOption
      option_error "Ambiguous option"
    rescue OptionParser::InvalidOption
      option_error "Invalid option"
    rescue OptionParser::InvalidArgument
      option_error "Invalid argument"
    rescue OptionParser::MissingArgument
      option_error "Missing argument"
    end
  end  # parse

  private 

  def option_error(msg)
    STDERR.print "Error: #{msg}\n\n #{@opt_parser}\n"
    exit 1
  end

end  # class OptionsStruct
