# Requires Ruby language 1.9 and MRI or Rubinius
require "redcard"
RedCard.verify :mri, :ruby, :rubinius, "1.9"

module Bosh
  module Deployer
  end
end

require "bosh-deployer/version"
require "bosh-deployer/stemcell"

# require "bosh-bootstrap/network"
# require "bosh-bootstrap/key_pair"
# require "bosh-bootstrap/microbosh"
