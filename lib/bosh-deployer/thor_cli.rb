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

    desc "generate_stub <NAME>", "Generates stub for bosh or cloudfoundry"
    def generate_stub(name)
      cmd = Bosh::Deployer::Cli::Commands::GenerateStub.new(name)
      cmd.perform
    end

    desc "target_deployment <MICROBOSH_OR_BOSH>", 
      "Tries to target an existent microbosh or bosh deployment done via bosh deployer"
    def target_deployment(name)
      cmd = Bosh::Deployer::Cli::Commands::Deployment.new(name)
      cmd.target(name)
    end
  end
end
