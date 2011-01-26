# RailRoad - RoR diagrams generator
# http://railroad.rubyforge.org
#
# Copyright 2007-2008 - Javier Smaldone (http://www.smaldone.com.ar)
# See COPYING for more details

require 'lib/diagram_graph'

# Root class for RailRoad diagrams
class AppDiagram

  def initialize(options)
    @options = options
    @graph = DiagramGraph.new
    @graph.show_label = false # @options.label

    STDERR.print "Loading application classes\n" if @options.verbose
    load_classes
  end

  # Print diagram
  def print
    old_stdout = STDOUT.dup
    begin
      STDOUT.reopen("diagram.dot")
    rescue
      STDERR.print "Error: Cannot write diagram to diagram.dot\n\n"
      exit 2
    end
    
    STDERR.print "Generating DOT graph\n" if @options.verbose
    STDOUT.print @graph.to_dot 

    STDOUT.reopen(old_stdout)
  end # print

  private 

  # Prevents Rails application from writing to STDOUT
  def disable_stdout
    @old_stdout = STDOUT.dup
    STDOUT.reopen(PLATFORM =~ /mswin/ ? "NUL" : "/dev/null")
  end

  # Restore STDOUT  
  def enable_stdout
    STDOUT.reopen(@old_stdout)
  end

  # Print error when loading Rails application
  def print_error(type)
    STDERR.print "Error loading #{type}.\n  (Are you running " +
                 "#{APP_NAME} on the aplication's root directory?)\n\n"
  end

  # Extract class name from filename
  def extract_class_name(filename)
    #filename.split('/')[2..-1].join('/').split('.').first.camelize
    # Fixed by patch from ticket #12742
    File.basename(filename).chomp(".rb").camelize
  end

end # class AppDiagram
