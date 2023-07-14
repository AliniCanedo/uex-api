class ApplicationService
  attr_reader :result, :errors

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def t(key, params={})
    I18n.t("services.#{service_name}.#{key}", params)
  end

  def service_name
    self.class.to_s.underscore.match(/(?<service_name>\S+)_service/)[:service_name]
  end
end
