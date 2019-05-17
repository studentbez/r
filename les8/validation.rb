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
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |validation|
        current_value = instance_variable_get("@#{validation[:name]}".to_sym)
        method = "validate_#{validation[:validation_type]}".to_sym
        send(method, validation[:name], current_value, validation[:other])
      end
    end

    def validate_presence(name, value, _)
      raise "Не может быть nil или пустым" if value.nil? || value == ''
    end

    def validate_format(name, value, format)
      raise "Некорректный формат" if value !~ format
    end

    def validate_type(name, value, type)
      raise "Некорректный тип" if value != type
    end
  end
end
