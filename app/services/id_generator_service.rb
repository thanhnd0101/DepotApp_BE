class IDGeneratorService < ApplicationService
  DEFAULT_LEN = 8

  def call
    SecureRandom.send(:choose, [*'a'..'z'], DEFAULT_LEN)
  end
end