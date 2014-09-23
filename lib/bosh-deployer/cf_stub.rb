require 'bosh-deployer/bosh_settings'
require 'bosh-deployer/stub'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::CFStub < Bosh::Deployer::Stub
  include Bosh::Deployer::BoshSettings

  def name
    'cloudfoundry'
  end
end
