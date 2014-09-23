require 'bosh-deployer/stub'
require 'bosh-deployer/microbosh_settings'
require 'bosh-deployer/bosh_settings'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::BoshStub < Bosh::Deployer::Stub
  include Bosh::Deployer::BoshSettings
  include Bosh::Deployer::MicroboshSettings

  def name
    'bosh'
  end
end
