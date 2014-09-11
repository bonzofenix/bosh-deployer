module Bosh; module Deployer; end ;end

class Bosh::Deployer::BoshStub
  include Cancun::Highline

  def initialize(path)
  end

  def generate
    say_bold 'Provide the following information for your bosh configuration:'
  end
end
