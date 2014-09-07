require 'cli'
require 'bosh/cli/commands/deployer' # "bosh bootstrap COMMAND" commands added to bosh CLI
require 'bosh-deployer/cli/commands/provision_stemcells'

describe Bosh::Cli::Command::Deployer do
  let(:cli) do
    described_class.new(nil)
  end
  let(:cmd){ double(Bosh::Deployer::Cli::Commands::ProvisionStemcells) }

  it 'runs upload stemcell command' do
    allow(cmd).to receive(:perform)
    expect(Bosh::Deployer::Cli::Commands::ProvisionStemcells)
      .to receive(:new).and_return(cmd)
      cli.provision_stemcells
  end
end
