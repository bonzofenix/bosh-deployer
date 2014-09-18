require 'bosh-deployer'
require 'bosh-deployer/thor_cli'
require 'bosh-deployer/cli/commands/generate_stub'
require 'bosh-deployer/cli/commands/provision_stemcells'

describe Bosh::Deployer::ThorCli do
  let(:cli){ described_class.new }

  describe 'generate_stub' do
    let(:cmd){ double.as_null_object }

    it 'should called generate stub with the correct commands' do
      expect(Bosh::Deployer::Cli::Commands::GenerateStub)
        .to receive(:new).with('bosh',anything).and_return(cmd)
        cli.generate_stub('bosh')
    end
  end

  describe 'provision_stemcells' do
    let(:cmd){ double.as_null_object }

    it 'should called generate stub with the correct commands' do
      allow(Bosh::Deployer::Cli::Commands::ProvisionStemcells)
        .to receive(:new).and_return(cmd)
      expect(cmd).to receive(:perform)
      cli.provision_stemcells
    end
  end
end
