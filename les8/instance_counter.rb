module InstanceCounter
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(NoInstances)
  end

  module NoInstances
    protected

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
