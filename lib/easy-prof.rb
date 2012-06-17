require "easy-prof/version"
require "ruby-prof"

module EasyProf
  def self.included(instrumented_class)
    instrumented_class.send(:extend, ClassMethods)
  end

  module ClassMethods
    def instrument(method_name)
      @methods ||= []
      @methods << method_name.to_sym

      self.class_eval do

        def thing_with_instrumentation(*args, &block)
        end
      end

      self.instance_eval do
        def method_added(method_name)
          puts method_name
          if @methods.include?(method_name)

            new_method = "#{method_name}_with_instrumentation".to_sym
            old_method = "#{method_name}_without_instrumentation".to_sym
            unless method_defined?(new_method)
              #define_method(new_method) do
              class_eval <<-CODEZ
              def #{new_method.to_s}(*args, &block)
                require 'ruby-prof'
                RubyProf.measure_mode = RubyProf::WALL_TIME
                RubyProf.start

                #{old_method}(*args, &block)

                results = RubyProf.stop
                profile_location = "tmp/profile-graph.html"
                File.open profile_location, 'w' do |file|
                  RubyProf::GraphHtmlPrinter.new(results).print(file)
                end
              end
              CODEZ
              #end
              alias_method old_method, method_name.to_sym
              alias_method method_name.to_sym, new_method
            end
          end
          super
        end

      end
    end
  end
end