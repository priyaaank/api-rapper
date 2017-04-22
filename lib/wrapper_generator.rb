class WrapperGenerator

  attr_accessor :global_config, :service

  def initialize
    self.global_config = GlobalConfig.instance
    self.service = Service.instance
  end

  def self.config(&block)
    WrapperGenerator.new.config(&block)
  end

  def config (&block)
		instance_eval &block if block
		self
	end

  def endpoint(name, url, &block)
    api = WebApi.new(self.global_config).init(name, url, &block)
    self.service.add_api(name, api)
  end

  def host_url(value)
    self.global_config.add_config("host_url", value)
  end

  def base_headers(header_hash={})
    self.global_config.add_config("base_headers", header_hash)
  end

end