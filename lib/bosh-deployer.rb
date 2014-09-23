# Requires Ruby language 1.9 and MRI or Rubinius
require "redcard"
RedCard.verify :mri, :ruby, :rubinius, "1.9"

module Bosh
  module Deployer
  end
end

require "bosh-deployer/version"
require "bosh-deployer/stemcell"
require "bosh-deployer/stub"
require "bosh-deployer/bosh_stub"
