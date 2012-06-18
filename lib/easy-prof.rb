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
        def profile(method, *args, &block)
          require 'ruby-prof'
          RubyProf.measure_mode = RubyProf::WALL_TIME
          RubyProf.start

          send(method, *args, &block)

          results = RubyProf.stop
          profile_location = "tmp/profile-graph.html"
          File.open profile_location, 'w' do |file|
            RubyProf::GraphHtmlPrinter.new(results).print(file)
          end
        end
      end

      self.instance_eval do

        def method_added(method_name)

          if @methods.include?(method_name)
            new_method = "#{method_name}_with_instrumentation".to_sym
            old_method = "#{method_name}_without_instrumentation".to_sym
            unless method_defined?(new_method)

              class_eval <<-CODEZ
              def #{new_method.to_s}(*args, &block)
                profile(:#{old_method}, *args, &block)
              end
              CODEZ

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
