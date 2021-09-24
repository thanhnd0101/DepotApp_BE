class ApplicationService
  def self.call(*args, &blocks)
    new(*args, &blocks).call
  end
end