module Store
  instance_eval do
    def load_dependencies!
      require "lib/authorization.rb"
    end

    # Loads up any and all model classes in this namespace.
    def load_models!
      unless @loaded
        Dir[File.join(File.dirname(__FILE__), 'model', '*.rb')].each do |file|
          require file
        end
        @loaded = true
      end
    end 
  end

  load_dependencies!
  load_models!
end
