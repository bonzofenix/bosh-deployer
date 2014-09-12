require 'cancun'
require "bosh-deployer/bosh_stub"
require "debugger"

describe Bosh::Deployer::BoshStub do
  include Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:bosh_stub){ described_class.new(path) }


  describe '#generate' do
    describe 'when setting bosh static range' do
      it 'asks for the intial available static ip' do
        execute!{ bosh_stub.generate }
        expect(output)
          .to include('Intial available static ip for deploying bosh:')
      end

      it 'asks for the last available static ip' do
        execute!{ bosh_stub.generate }
        expect(output)
          .to include('Last available static ip for deploying bosh:')
      end
      
      it 'sets the range correctly' do
      execute do
        bosh_stub.generate
      end.and_type '10.10.10.10', '11.11.11.11'
      expect(bosh_stub.static_ip).to eq('')
      end.and_type '10.10.10.10 - 11.11.11.11'
      end
    end


    it 'generates the manifest correctly' do
      execute do
        bosh_stub.generate
      end.and_type '10.10.10.10', '11.11.11.11'
    end
  end

end
