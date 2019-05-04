module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation_type, other = nil)
      self.validations ||= []
      self.validations << { name: name,
                            validation_type: validation_type,
                            other: other }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |validation|
        name = validation[:name]
        current_value = instance_variable_get("@#{name}".to_sym)
        method = "validate_#{validation[:validation_type]}".to_sym
        send(method, name, current_value, validation[:other])
      end
      true
    end

    def validate_presence(name, value, _)
      return unless value.nil? || value.empty?
      raise "Не может быть nil или пустым"
    end

    def validate_format(name, value, format)
      return if value =~ format
      raise "Некорректный формат"
    end

    def validate_type(name, value, type)
      return if value != type
      raise "Некорректный тип"
    end
  end
end
