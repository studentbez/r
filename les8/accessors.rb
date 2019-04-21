module Accessor
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_and_method(name)
      define_method("#{name}".to_sym) do |value|
        instance_variable_set(@var_name, value)
      end
      var_history = history_getter(name)
      history_setter(name, @var_name, var_history)
    end
  end

  def strong_attr_accessor(name, class_name)
    var_and_method(name)
    define_method("#{name}".to_sym) do |value|
      raise TypeError unless value.is_a?(class_name)
      instance_variable_set(@var_name, value)
    end
  end

  private

  def var_and_method(name)
    @var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(@var_name) }
  end

  def history_getter(name)
    var_history = "@#{name}_history".to_sym
    define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }
  end

  def history_setter(name, var_name, var_history)
    define_method("#{name}_history".to_sym) do |value|
      instance_variable_set(var_name, value)
      history =
        if instance_variable_defined?(var_history)
          instance_variable_get(var_history)
        else
          instance_variable_set(var_history, [])
        end
      history << value
    end
  end
end
