require 'cancun'
require 'bosh-deployer/cf_stub'
require_relative 'support/helper'


describe Bosh::Deployer::CFStub do
  include ::Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:cf_stub){ described_class.new(path) }

  describe '#generate' do
    let(:settings_file) do
      File.new('spec/fixtures/bosh-bootstrap/settings.yml')
    end

    let(:args) do
      [ '', '', '' ]
    end

    describe 'when .bootstrap/settings.yml exist' do
      before do
        `rm -rf tmp ; mkdir tmp`
        allow(File).to receive(:exists?).and_call_original
        allow(File).to receive(:exists?)
          .with('~/.bootstrap/settings.yml').and_return(true)
        allow_any_instance_of(ReadWriteSettings)
          .to receive(:open).and_call_original
        allow_any_instance_of(ReadWriteSettings)
          .to receive(:open).with('~/.bootstrap/settings.yml')
          .and_return(settings_file)
      end


      it 'should generate the stub correctly' do
        # execute do
          # cf_stub.generate
        # end.and_type  *args
        # sleep 1 #TODO: develop wait for cmd after and type
        # equal_yaml('spec/fixtures/stubs/cloudfoundry.yml', 'tmp/cloudfoundry.yml')
      end
    end

    describe 'when .bootstrap/settings.yml does not exist' do
      let(:args) do
        [ ]
      end
      before { `rm -rf tmp ; mkdir tmp` }

      it 'should generate the stub correctly' do
        # execute do
          # cf_stub.generate
        # end.and_type  *args

        # equal_yaml('spec/fixtures/stubs/cloudfoundry.yml', 'tmp/cloudfoundry.yml')
      end
    end
  end
end
