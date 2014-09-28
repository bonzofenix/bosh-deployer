require 'bosh-deployer/stub'
require 'bosh-deployer/bosh_settings'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::CFStub < Bosh::Deployer::Stub
  include Bosh::Deployer::BoshSettings

  def name
    'cloudfoundry'
  end

  def floating_static_ip
    @floating_static_ip ||= ask('Available floating ip for cf:')
  end
end
