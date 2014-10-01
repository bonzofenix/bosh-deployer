require_relative 'support/helper'
require 'bosh-deployer/bosh_stub'
require 'cancun'
require 'yaml'

describe Bosh::Deployer::BoshStub do
  include ::Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:bosh_stub){ described_class.new(path) }

  describe '#generate' do
    let(:microbosh_settings) do
      Bosh::Deployer::MicroboshSettings.new(
        'spec/fixtures/bosh-bootstrap/settings.yml'
      )
    end

    let(:args) do
      [ '', '', '10.10.10.10', '11.11.11.11', '','','', '', '', '', '', '' ]
    end

    describe 'when .bootstrap/settings.yml exist' do
      before do
        `rm -rf tmp ; mkdir tmp`
        allow(Bosh::Deployer::MicroboshSettings)
          .to receive(:load).and_return(microbosh_settings)
      end


      it 'should generate the stub correctly' do
        execute do
          bosh_stub.generate
        end.and_type  *args
        sleep 1 #TODO: develop wait for cmd after and type
        equal_yaml('spec/fixtures/stubs/bosh.yml', 'tmp/bosh.yml')
      end
    end

    describe 'when .bootstrap/settings.yml does not exist' do
      let(:args) do
        [ 'IP', 'SUBNET_ID', '10.10.10.10', '11.11.11.11',
          '10.10.10.0/24', '10.10.10.1','https://example.com:5000/v2.0',
          'admin', 'admin', 'dev', '', '', '' ]
      end
      before { `rm -rf tmp ; mkdir tmp` }

      it 'should generate the stub correctly' do
        execute do
          bosh_stub.generate
        end.and_type  *args

        equal_yaml('spec/fixtures/stubs/bosh.yml', 'tmp/bosh.yml')
      end
    end
  end
end
