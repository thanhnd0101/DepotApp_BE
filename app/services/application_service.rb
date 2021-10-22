class ApplicationService
  def initialize(*args, &block)
  end

  def self.call(*args, &blocks)
    new(*args, &blocks).call
  end
end