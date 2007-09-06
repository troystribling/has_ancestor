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
                meth_class = self.class.ancestor_for_attribute(meth) 
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
                 if self.respond_to?(meth_class.tableize.singularize.to_sym)
                   get_#{parent}.send(meth, *args, &blk)
                 else
                   self.descendant_method_missing(meth, *args, &blk)
                 end
                end
              end
    
              def self.method_missing(meth, *args, &blk)
                if finder = /^find_(all_by|by)_([_a-zA-Z]*)$/.match(meth.to_s)
                  self.build_finder(finder, *args)
                else
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
              end

              def self.build_finder(finder, *args)
                finder_type = finder.captures.first == 'all_by' ? :all : :first
                finder_attr = finder.captures.last.split('_and_')
                attr_count = finder_attr.length
                finder_cond = " "
                (0..attr_count-1).each do |i|
                  finder_cond << self.ancestor_for_attribute(finder_attr[i].to_sym).tableize + "." +
                  finder_attr[i] + " = " + self.add_attribute(args[i])
                  i.eql?(finder_attr.length-1) ? finder_cond << " " : finder_cond << " and " 
                end
                if args[attr_count].nil?
                  args[attr_count] = {:conditions => conditions, :joins => joins}
                else
                  args[attr_count].include?(:conditions) ? args[attr_count][:conditions] << ' and ' + finder_cond : args[attr_count][:conditions] = finder_cond
                end
              end
                          
              def self.add_attribute(attr)
                case
                  when attr.class.eql?(String) : "'" + attr + "'"
                  else attr.to_s
                end
              end
                  
            do_eval
    
          end           
    
        end
        
      end

    end

  end

end