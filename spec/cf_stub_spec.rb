require 'cancun'
require 'bosh-deployer/cf_stub'
require_relative 'support/helper'


describe Bosh::Deployer::CFStub do
  include ::Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:cf_stub){ described_class.new(path) }

  describe '#generate' do
    let(:microbosh_settings) do
      Bosh::Deployer::MicroboshSettings.new(
        'spec/fixtures/bosh-bootstrap/settings.yml'
      )
    end
    let(:args) do
      ['2.2.2.2', '10.0.0.0/8', '1.2.3.4', 'MICROBOSH_SUBNET_ID', '3.3.3.3']
    end

    describe 'when .bootstrap/settings.yml exist' do
      before do
        `rm -rf tmp ; mkdir tmp`
        allow(Bosh::Deployer::MicroboshSettings)
          .to receive(:load).and_return(microbosh_settings)
      end

      it 'should generate the stub correctly' do
        execute do
          cf_stub.generate
        end.and_type  *args
        sleep 1 #TODO: develop wait for cmd after and type
        equal_yaml('spec/fixtures/stubs/cloudfoundry.yml', 'tmp/cloudfoundry.yml')
      end
    end
  end
end
