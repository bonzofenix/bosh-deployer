
require 'bosh-deployer/cli/commands/deployment'

describe Bosh::Deployer::Cli::Commands::Deployment do
  describe '#target' do
    [{
      name: 'bosh',
      ip:  '10.230.12.11',
      filepath: 'spec/fixtures/manifests/bosh.yml',
      default_filepath: "#{ENV['HOME']}/.deployer/stubs/bosh.yml"
    },{
      name: 'microbosh',
      ip:  'IP',
      filepath: 'spec/fixtures/bosh-bootstrap/settings.yml',
      default_filepath: "#{ENV['HOME']}/.microbosh/settings.yml"
    }].each do |dep|
      describe "when targeting #{dep[:name]} providing yml \
source #{dep[:filepath]}" do
        let(:name){ dep[:name] }
        let(:filepath){ dep[:filepath] }
        let(:deployment){ described_class.new(name, filepath) }

        it 'should target to the correct address' do
          expect(deployment).to receive(:`)
          .with("bosh target #{dep[:ip]}")
          deployment.target
        end
      end

      describe 'when using default sources' do
        let(:name){ dep[:name] }
        let(:filepath){ dep[:filepath] }
        let(:deployment){ described_class.new(name) }

        it{ expect(deployment.filepath).to eq(dep[:default_filepath]) }
      end
    end
  end
end
