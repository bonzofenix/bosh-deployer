
require 'bosh-deployer/cli/commands/deployment'

describe Bosh::Deployer::Cli::Commands::Deployment do
  let(:deployment){ described_class.new(name, filepath) }

  [{
    name: 'bosh',
    ip:  '10.230.12.11',
    filepath: 'spec/fixtures/manifests/bosh.yml'
  },{ 
    name: 'microbosh',
    ip:  'IP',
    filepath: 'spec/fixtures/bosh-bootstrap/settings.yml'
  }].each do |dep|
    describe "#target #{dep[:name]}" do
      let(:name){ dep[:name] }
      let(:filepath){ dep[:filepath] }

      it 'should target to the correct ip' do
        expect(deployment).to receive(:`)
          .with("bosh target #{dep[:ip]}")
        deployment.target
      end
    end
  end
end
