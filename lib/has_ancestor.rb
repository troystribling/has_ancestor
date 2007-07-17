
module PlanB #:nodoc

  class InvalidType < ArgumentError; end  

  module Has #:nodoc
    module Ancestor #:nodoc

      ####################################################
      def self.included(base)
        base.extend(ClassMethods)  
      end
  
      ####################################################
      module ClassMethods
  
        def has_descendants
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("belongs_to :#{self.name.tableize.singularize}_descendant, :polymorphic => true")
          include InstanceMethods::AncestorAndDescendantMethods
          InstanceMethods::AncestorMethods.add_methods(self)
        end
        
        def has_ancestor(args) 
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("has_one args[:named], :as => :#{args[:named]}_descendant, :dependent => :destroy")
          include InstanceMethods::AncestorAndDescendantMethods
          InstanceMethods::DescendantMethods.add_methods(self, args[:named])
        end       
                                
      end
  
      ####################################################
      module InstanceMethods

        ####################################################
        module AncestorAndDescendantMethods
    
          def to_descendant(arg = nil)
            if arg.nil?
              if descendant.nil?
                self
              else
                descendant.to_descendant
              end
            else  
              if self.class.name.eql?(arg.to_s.classify)
                self
              else
                if descendant.nil?
                  raise(PlanB::InvalidType, "target model is invalid")
                else
                  descendant.to_descendant(arg)
                end
              end
            end
          end
  
          def descendant
            respond_to?(:get_descendant) ? get_descendant : nil
          end
  
          def ancestor
            respond_to?(:get_ancestor) ? get_ancestor : nil
          end
  
          def descendant_of?(ancestor_model)
            unless ancestor.nil?
              ancestor.class.name.eql?(ancestor_model.to_s.classify) ? \
                true : ancestor.descendant_of?(ancestor_model)
             else
               false
             end
          end

        end
        
        ####################################################
        module AncestorMethods
    
          def self.add_methods(target)
    
            target.class_eval <<-do_eval

              def get_descendant
                #{target.to_s.tableize.singularize}_descendant      
              end
                  
            do_eval
    
          end           
    
        end
  
        ####################################################
        module DescendantMethods
    
          def self.add_methods(target, parent)
    
            target.class_eval <<-do_eval
    
              def initialize(*args)
                super
                get_#{parent}.#{parent}_descendant = self
                descendant_initialize(*args) if respond_to?(:descendant_initialize)
              end
        
              def get_#{parent}
                build_#{parent} if #{parent}.nil?      
                #{parent}
              end

              def get_ancestor
                get_#{parent}      
              end
           
              def attributes
                super.merge(get_#{parent}.attributes)
              end
    
              def method_missing(meth, *args, &blk)  
                begin
                  super
                rescue NoMethodError
                  get_#{parent}.send(meth, *args, &blk)
                end
              end
    
              def self.method_missing(meth, *args, &blk)
                begin
                  super
                rescue NoMethodError
                  #{parent.to_s.classify}.send(meth, *args, &blk)
                end
              end
    
            do_eval
    
          end           
    
        end

      end
  
      ####################################################
      module SingletonMethods
      end
                
    end
  end 
     
end