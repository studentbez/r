module InstanceCounter
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(Instances)
  end

  protected

  module Instances
    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances = 0 if self.class.instances == nil 
      self.class.instances += 1
    end
  end
end
