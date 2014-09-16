require 'cli'
require 'bosh/cli/commands/deployer' # "bosh bootstrap COMMAND" commands added to bosh CLI
require 'bosh-deployer/cli/commands/provision_stemcells'
require 'bosh-deployer/cli/commands/generate_stub'

describe Bosh::Cli::Command::Deployer do
  let(:cli) do
    described_class.new(nil)
  end

  describe 'provision stemcells' do
    let(:cmd){ double(Bosh::Deployer::Cli::Commands::ProvisionStemcells) }

    it 'should runs upload stemcell command' do
      allow(cmd).to receive(:perform)
      expect(Bosh::Deployer::Cli::Commands::ProvisionStemcells)
      .to receive(:new).and_return(cmd)
      cli.provision_stemcells
    end
  end

  describe 'generate stubs' do
    let(:cmd){ double(Bosh::Deployer::Cli::Commands::GenerateStub) }

    it 'should generate stub' do
      allow(cmd).to receive(:perform)
      expect(Bosh::Deployer::Cli::Commands::GenerateStub)
        .to receive(:new).and_return(cmd)
      cli.generate_stub('name', 'path')
    end
  end
end
