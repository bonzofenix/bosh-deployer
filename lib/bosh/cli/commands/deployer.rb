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
  end
end
