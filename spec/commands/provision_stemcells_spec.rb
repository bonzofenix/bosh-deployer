require "bosh-deployer/cli/commands/provision_stemcells"
require "bosh-deployer/stemcell"

describe Bosh::Deployer::Cli::Commands::ProvisionStemcells do
  let(:cmd) { described_class.new }
  let(:stemcell) { double.as_null_object }

  before do
    allow(Bosh::Deployer::Stemcell).to receive(:new)
    .with('bosh-openstack-kvm-ubuntu-lucid-go_agent', 'latest')
    .and_return(stemcell)
  end

  describe '#perform' do
    let(:perform_provision_stemcells){ cmd.perform(manifest_path) }
    let(:manifest_path){ 'spec/fixtures/manifests/cf.yml' }

    describe 'when filename is provided' do
      # meta:
      #   stemcell:
      #     name: bosh-openstack-kvm-ubuntu-lucid-go_agent
      #     version: latest

      it 'download the stemcell' do
        expect(stemcell).to receive(:download)
        perform_provision_stemcells
      end

      it 'should upload stemcell to targeted bosh' do
        expect(stemcell).to receive(:upload)
        perform_provision_stemcells
      end
    end


    describe 'when when filename is not provided'  do
      let(:perform_provision_stemcells){ cmd.perform }
      before do
        allow(cmd).to receive(:`)
          .with('bosh deployment')
          .and_return("Current deployment is `#{manifest_path}'\n")
      end

      describe 'when deployment is target ' do
        it 'should use the target deployment manifest' do
          perform_provision_stemcells
          expect(cmd.manifest_path)
            .to eq('spec/fixtures/manifests/cf.yml')
        end
      end

      it 'should raise error with missing arguments' do
      end
    end
  end
end
