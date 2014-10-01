require "bosh-deployer"

module Bosh::Cli::Command
  class Deployer < Base
    usage "deployer"
    desc  "show deployer sub-commands"
    def help
      say("bosh deployer sub-commands:")
      nl
      cmds = Bosh::Cli::Config.commands.values.find_all {|c|
        c.usage =~ /^deployer/
      }
      Bosh::Cli::Command::Help.list_commands(cmds)
    end

    usage "deployer provision stemcells"
    desc "finds and uploads the required stemcell point out in your manifest to bosh"
    def provision_stemcells
      require "bosh-deployer/cli/commands/provision_stemcells"
      Bosh::Deployer::Cli::Commands::ProvisionStemcells.new.perform
    end

    usage "deployer generate stub"
    desc "Creates stub file to be compile with Spiff."
    def generate_stub(name, path=nil)
      require "bosh-deployer/cli/commands/generate_stub"
      Bosh::Deployer::Cli::Commands::GenerateStub.new(name,path).perform
    end

    usage "deployer target"
    desc "Targets bosh or microbosh from a deployment.yml, stub.yml or bosh-bootstrap microbosh settings.yml"
    def target_deployment(name, filepath=nil)
      require "bosh-deployer/cli/commands/deployment"
      Bosh::Deployer::Cli::Commands::Deployment.new(name, filepath).target
    end
  end
end
