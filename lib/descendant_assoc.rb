####################################################
module PlanB 
  
  ####################################################
  module Has 

    ####################################################
    module Ancestor 

      ####################################################
      module InstanceMethods

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
              p meth
              p self.class.name
                meth_class = self.class.ancestor_for_attribute(meth) 
              p self.class.ancestor_for_attribute(meth)
                if meth_class.nil? || meth_class == self.class.name
                  begin
                    super
                  rescue NoMethodError
                    if self.respond_to?(:descendant_method_missing)
                      self.descendant_method_missing(meth, *args, &blk)
                    else
                      get_#{parent}.send(meth, *args, &blk)
                    end
                  end
                else
                p eval(meth_class.tableize.singularize).send(meth, *args, &blk)
                 eval(meth_class.tableize.singularize).send(meth, *args, &blk)
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
    
            do_eval
    
          end           
    
        end
        
      end

    end

  end

end