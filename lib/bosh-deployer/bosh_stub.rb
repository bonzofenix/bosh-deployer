require 'bosh-deployer/stub'
require 'bosh-deployer/bosh_settings'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::BoshStub < Bosh::Deployer::Stub
  include Bosh::Deployer::BoshSettings

  def name
    'bosh'
  end
end
