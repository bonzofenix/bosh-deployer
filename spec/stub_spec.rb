require 'cancun'
require 'bosh-deployer/stub'

describe Bosh::Deployer::Stub do

  class FooStub < Bosh::Deployer::Stub
    def name
      'foo'
    end
  end

  include ::Cancun::Test
  before{ init_cancun_test }

  let(:path){ 'tmp/'}
  let(:stub){ FooStub.new(path) }

  describe '#name' do
    it 'raise not implemented ' do
      expect{described_class.new.name}.to raise_error(NotImplementedError)
    end
  end

  describe '#new' do
    describe 'when path is given' do
      it 'sets the filename to PATH/stubs' do
        expect(stub.filename).to eq('tmp/foo.yml')
      end
    end

    describe 'when path is not given' do
      let(:stub){ FooStub.new }

      it 'sets the filename to ~/.bosh-deployer/stubs' do
        expect(stub.filename).to eq('~/.bosh-deployer/stubs/foo.yml')
      end
    end
  end


  describe 'when stub already exists' do
    before do
      `rm -rf tmp ; mkdir tmp`
      `echo 'something' > tmp/foo.yml`
    end

    let(:args){ %w{ n } }

    it 'should not change stub if user does not want to edit it' do
      execute do
        stub.generate
      end.and_type  *args
      expect(output).to include('Stub generation cancelled!')
    end
  end
end
