require 'cancun/test'
require 'byebug'
require "bosh-deployer/bosh_stub"

describe Bosh::Deployer::BoshStub do
  include Cancun::Test

  let(:path){ 'tmp/'}
  let(:bosh_stub){ described_class.new(path) }

  before { init_cancun_test }

  describe '#generate' do
    it 'asks for the intial available static ip' do
      execute{ bosh_stub.generate }.run
      expect(output)
        .to include('Intial available static ip for deploying bosh:')
    end

    it 'asks for the last available static ip' do
      execute { bosh_stub.generate }.run
      expect(output)
        .to include('Last available static ip for deploying bosh:')
    end

    it 'generates the manifest correctly' do
      execute do
        bosh_stub.generate
      end.and_type '10.10.10.10', '11.11.11.11'
    end
  end

end
