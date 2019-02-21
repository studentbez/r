module InstanceCounter
  attr_accessor :count_of_instances

  @@count_of_instances = 0

  def self.included(base)
    base.include(InstanseMethods)
  end

  def self.instances
    @@count_of_instances
  end

  module InstanseMethods
    protected

    def register_instance
      @@count_of_instances += 1
    end
  end
end
