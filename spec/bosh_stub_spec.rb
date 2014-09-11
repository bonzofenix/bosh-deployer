require "bosh-deployer/bosh_stub"

describe Bosh::Deployer::BoshStub do
  include Cancun::Highline

  let(:path){ 'tmp/'}
  let(:bosh_stub){ BoshStub.new(path) }

  before { init_highline_test }
  
  describe '#generate' do
    it 'asks for the intial available static ip' do
      execute { bosh_stub.generate }
      expect(output)
        .to include('Intial available static ip for deploying bosh:')
    end

    it 'asks for the last available static ip' do
      execute { bosh_stub.generate }
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
