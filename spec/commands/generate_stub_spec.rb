require "bosh-deployer/cli/commands/generate_stub"
require "bosh-deployer/bosh_stub"

describe Bosh::Deployer::Cli::Commands::GenerateStub do
  let(:cmd) { described_class.new(*args) }

  let(:bosh_stub) { double.as_null_object }
  let(:path) { 'tmp/' }

  before do
    allow(Bosh::Deployer::BoshStub).to receive(:new)
    .and_return(bosh_stub)
  end

  describe 'when creating bosh stub' do
    let(:args){ %w{bosh} }

    describe '#perform' do
      let(:generate_stub){ cmd.perform }

      describe 'when no stub exists' do
        it 'generates the stub' do
          expect(bosh_stub).to receive(:generate)
          generate_stub
        end
      end
    end
  end
end
