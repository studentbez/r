module InstanceCounter
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(CouldntThinkOf)
  end

  protected

  module CouldntThinkOf
    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances = 0 if self.class.instances == nil 
      self.class.instances += 1
    end
  end
end
