# RailRoad - RoR diagrams generator
# http://railroad.rubyforge.org
#
# Copyright 2007-2008 - Javier Smaldone (http://www.smaldone.com.ar)
# See COPYING for more details

require 'lib/app_diagram'

# RailRoad models diagram
class ModelsDiagram < AppDiagram

  def initialize (options)
    super options 
    @graph.diagram_type = 'Models'
    @habtm = []
  end

  # Process model files
  def generate
    STDERR.puts "Generating models diagram\n" if @options.verbose
    files = Dir.glob(@options.model_dir + "/*.rb")
    files.each { |f| process_class extract_class_name(f).constantize }
  end 

  private

  # Load model classes
  def load_classes
    begin
      disable_stdout
      files = Dir.glob(@options.model_dir + "/*.rb")
      files.each {|m| require m }
      enable_stdout
    rescue LoadError
      enable_stdout
      print_error "model classes"
      raise
    end
  end  # load_classes

  # Process a model class
  def process_class(current_class)

    STDERR.print "\tProcessing #{current_class}\n" if @options.verbose

    generated = false
        
    # Is current_clas derived from ActiveRecord::Base?
    if current_class.respond_to?'reflect_on_all_associations'

      node_attribs = []
      node_type = 'model'
      # Collect model's content columns
	
      current_class.content_columns.each do |a|
        content_column = a.name
        content_column += ' :' + a.type.to_s 
        node_attribs << content_column
      end

      @graph.add_node [node_type, current_class.name, node_attribs]
      generated = true
      current_class.reflect_on_all_associations.each do |a|
        process_association current_class.name, a
      end
    end
  end # process_class

  # Process a model association
  def process_association(class_name, assoc)

    STDERR.print "\t\tProcessing model association #{assoc.name.to_s}\n" if @options.verbose

    # Skip "belongs_to" associations
    return if assoc.macro.to_s == 'belongs_to'

    # Only non standard association names needs a label
    
    # from patch #12384
    # if assoc.class_name == assoc.name.to_s.singularize.camelize
    assoc_class_name = (assoc.class_name.respond_to? 'underscore') ? assoc.class_name.underscore.singularize.camelize : assoc.class_name 
    if assoc_class_name == assoc.name.to_s.singularize.camelize
      assoc_name = ''
    else
      assoc_name = assoc.name.to_s
    end 

    if assoc.macro.to_s == 'has_one' 
      assoc_type = 'one-one'
    elsif assoc.macro.to_s == 'has_many' && (! assoc.options[:through])
      assoc_type = 'one-many'
    else # habtm or has_many, :through
      return if @habtm.include? [assoc.class_name, class_name, assoc_name]
      assoc_type = 'many-many'
      @habtm << [class_name, assoc.class_name, assoc_name]
    end  
    # from patch #12384    
    # @graph.add_edge [assoc_type, class_name, assoc.class_name, assoc_name]
    @graph.add_edge [assoc_type, class_name, assoc_class_name, assoc_name]    
  end # process_association

end # class ModelsDiagram
