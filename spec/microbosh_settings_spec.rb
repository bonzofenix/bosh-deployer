require 'bosh-deployer/microbosh_settings'

describe Bosh::Deployer::MicroboshSettings do
  let(:filepath){ 'spec/fixtures/bosh-bootstrap/settings.yml' }

  describe '#load' do
    describe 'when filepath received' do
      let(:settings){ described_class.new(filepath) }

      it{ expect(settings.filepath).to eq(filepath) }

      it 'access atts' do
        expect(settings.address.ip).to be
      end
    end

    describe 'when filepath not received' do
      let(:settings){ described_class.new }

      it{ expect(settings.filepath).to eq('~/.bootstrap/settings.yml') }
    end
  end
end
