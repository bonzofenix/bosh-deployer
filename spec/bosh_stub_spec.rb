require 'cancun'
require 'bosh-deployer/bosh_stub'
require 'yaml'

class Hash
  def sort_by_key(recursive = false, &block)
    self.keys.sort(&block).reduce({}) do |seed, key|
      seed[key] = self[key]
      if recursive && seed[key].is_a?(Hash)
        seed[key] = seed[key].sort_by_key(true, &block)
      end
      seed
    end
  end
end

def equal_yaml(expected_file, actual_file)
  @expected_content = File.read(expected_file)
  @actual_content = File.read(actual_file)

  expected = YAML.load(@expected_content).sort_by_key(true).to_a
  actual = YAML.load(@actual_content).sort_by_key(true).to_a

  expect(expected).to eq(actual)
end

describe Bosh::Deployer::BoshStub do
  include ::Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:bosh_stub){ described_class.new(path) }

  describe '#new' do
    describe 'when path is given' do
      it 'sets the filename to PATH/stubs' do
        expect(bosh_stub.filename).to eq('tmp/bosh.yml')
      end
    end

    describe 'when path is not given' do
      let(:bosh_stub){ described_class.new }

      it 'sets the filename to ~/.bosh-deployer/stubs' do
        expect(bosh_stub.filename).to eq('~/.bosh-deployer/stubs/bosh.yml')
      end
    end
  end

  describe '#generate' do
    let(:settings_file) do
      File.new('spec/fixtures/bosh-bootstrap/settings.yml')
    end

    let(:args) do
      [ '', '', '10.10.10.10', '11.11.11.11', '','','', '', '', '', '', '' ]
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

    describe 'when stub already exists' do
      before do
        `rm -rf tmp ; mkdir tmp`
        `echo 'something' > tmp/bosh.yml` 
      end

      let(:args){ %w{ n } }

      it 'should not change stub if user does not want to edit it' do
        execute do
          bosh_stub.generate
        end.and_type  *args
        expect(output).to include('Stub generation cancelled!')
      end
    end
  end

end
