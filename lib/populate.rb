require 'ffaker'
require 'rainbow'

require 'populate/base'
require 'populate/version'

module Populate
end

module Kernel
  def populate(klass, amount = 100)
    Populate::Base.new(klass, amount).populate!
  end
end
