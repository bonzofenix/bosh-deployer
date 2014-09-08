require "bosh-deployer/cli/commands/provision_stemcells"
require "bosh-deployer/stemcell"

describe Bosh::Deployer::Cli::Commands::ProvisionStemcells do
  let(:cmd) { described_class.new }
  let(:stemcell) { double.as_null_object }

  before do
    allow(Bosh::Deployer::Stemcell).to receive(:new)
    .with(stemcell_name, stemcell_version)
    .and_return(stemcell)
  end

  describe '#perform' do
    let(:perform_provision_stemcells){ cmd.perform(manifest_path) }

    describe 'when filename is provided' do
      [{
        manifest: 'spec/fixtures/manifests/cf.yml',
        name: 'bosh-openstack-kvm-ubuntu-lucid' ,
        version: 'latest'
      },
      {
        manifest: 'spec/fixtures/manifests/bosh.yml',
        name: 'bosh-openstack-kvm-ubuntu-trusty-go_agent' ,
        version: 'latest'
      }
      ].each do |n|
        describe "when manifest #{n[:manifest]}" do
          let(:manifest_path){ n[:manifest] }
          let(:stemcell_name){ n[:name] }
          let(:stemcell_version){ n[:version] }

          it 'download the stemcell' do
            expect(stemcell).to receive(:download)
            perform_provision_stemcells
          end

          it 'should upload stemcell to targeted bosh' do
            expect(stemcell).to receive(:upload)
            perform_provision_stemcells
          end
        end
      end
    end


    describe 'when when filename is not provided'  do
      let(:manifest_path){ 'spec/fixtures/manifests/cf.yml' }
      let(:stemcell_name){ 'bosh-openstack-kvm-ubuntu-lucid' }
      let(:stemcell_version){ 'latest' }
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
