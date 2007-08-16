####################################################
module PlanB 
  
  ####################################################
  # invalid attribute type specified
  class InvalidType < ArgumentError; end  

  ####################################################
  module Has 

    ####################################################
    module Ancestor 

      ###################################################
      def self.included(base) #:nodoc
        base.extend(ClassMethods)  
      end
  
      ###################################################
      module ClassMethods
  
        #################################################
        # Declare a model has descendants
        def has_descendants
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("belongs_to :#{self.name.tableize.singularize}_descendant, :polymorphic => true")
          InstanceMethods::AncestorAndDescendantMethods.add_methods(self, '')
          InstanceMethods::AncestorMethods.add_methods(self)
        end
        
        ##################################################
        # Declare a model ancestor
        def has_ancestor(args = {}) 
          self.primary_key = "#{self.name.tableize.singularize}_id"
          eval("has_one args[:named], :as => :#{args[:named]}_descendant, :dependent => :destroy")
          InstanceMethods::AncestorAndDescendantMethods.add_methods(self, args[:named])
          InstanceMethods::DescendantMethods.add_methods(self, args[:named])
        end       
                                
      end
  
      ####################################################
      module InstanceMethods

        ##################################################
        module AncestorAndDescendantMethods 

          def self.add_methods(target, parent)
    
             target.class_eval <<-do_eval
              
              ####################################################
              # ancestor class hierarchy
              "#{parent}" != "" ? @@ancestor_class = eval("#{parent}".classify) : @@ancestor_class = nil

              def self.class_hierarchy
                @@ancestor_class == nil ? [self.name] : [self.name] + @@ancestor_class.class_hierarchy
              end
              
              def class_hierarchy
                self.class.class_hierarchy
              end
    
              ####################################################
              # Return descendant model if specified and throw 
              # Planb::InvalidType if model is not a descendant. 
              # If model is not specified return model at root of 
              # inheritance hierarchy.
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
    
              ####################################################
              # Returns true if specified model is a descendant 
              # of model and false if not.
              def descendant
                respond_to?(:get_descendant) ? get_descendant : nil
              end
      
              ####################################################
              # Return descendant model instance. If model has no 
              # descendant return nil.
              def ancestor
                respond_to?(:get_ancestor) ? get_ancestor : nil
              end
      
              def self.ancestor
                @@ancestor_class
              end
              
              ####################################################
              # Returns true if specified model is a descendant of 
              # model and false if not.
              def descendant_of?(ancestor_model)
                unless ancestor.nil?
                  ancestor.class.name.eql?(ancestor_model.to_s.classify) ? \
                    true : ancestor.descendant_of?(ancestor_model)
                 else
                   false
                 end
              end

            do_eval

          end
          
        end
        
        ##################################################
        module AncestorMethods #:nodoc :all
    
          def self.add_methods(target)
    
            target.class_eval <<-do_eval

              def get_descendant
                #{target.to_s.tableize.singularize}_descendant      
              end
                  
            do_eval
    
          end           
    
        end
  
        ##################################################
        module DescendantMethods #:nodoc :all
    
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

              def update
                super
                get_#{parent}.update
              end
    
              def method_missing(meth, *args, &blk) 
                begin
                  super
                rescue NoMethodError
                  if self.respond_to?(:descendant_method_missing)
                    self.descendant_method_missing(meth, *args, &blk)
                  else
                    get_#{parent}.send(meth, *args, &blk)
                  end
                end
              end
    
              def self.method_missing(meth, *args, &blk)
                begin
                  super
                rescue NoMethodError
                  if self.respond_to?(:descendant_method_missing)
                    self.descendant_method_missing(meth, *args, &blk)
                  else
                    #{parent.to_s.classify}.send(meth, *args, &blk)
                  end
                 end
              end
    
              def self.find_model(args = {})
                args.include?(:joins) ? args[:joins] << do_joins : args[:joins] = do_joins
                find(args)
              end

             def self.do_joins
               ch = class_hierarchy
               joins = ""
               if ch.length > 1
                 (0..ch.length-2).each do |i|
                   joins << " LEFT JOIN " + ch[i+1].tableize + " ON " + ch[i+1].tableize.singularize +
                            "_descendant_id = " + ch[i].tableize.singularize + "_id "
                 end
               end
               joins
             end

            do_eval
    
          end           
    
        end

      end
  
      ####################################################
      module SingletonMethods #:nodoc :all
      end
                
    end
  end 
     
end