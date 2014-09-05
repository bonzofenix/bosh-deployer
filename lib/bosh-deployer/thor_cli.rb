require "thor"
require "bosh-deployer"

module Bosh::Deployer
  class ThorCli < Thor

    desc "provision_stemcells", "Download and uploads stemcells indicated in a manifest to the current target bosh"
    def provision_stemcells(manifest_path = nil)
      require "bosh-deployer/cli/commands/provision_stemcells"
      deploy_cmd = Bosh::Deployer::Cli::Commands::ProvisionStemcells.new
      deploy_cmd.perform(manifest_path)
    end
  end
end
