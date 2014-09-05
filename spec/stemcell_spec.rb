require "bosh-deployer/stemcell"

describe Bosh::Deployer::Stemcell do
  let(:stemcell){described_class.new(name, version) }

  [{
    name: 'bosh-openstack-kvm-ubuntu-lucid',
    version: 'latest',
    expected_url: 'https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/openstack/bosh-stemcell-latest-openstack-kvm-ubuntu-lucid-go_agent.tgz',
    expected_tar: 'bosh-stemcell-latest-openstack-kvm-ubuntu-lucid-go_agent.tgz'
  },
  {
    name: 'bosh-openstack-kvm-ubuntu-lucid-go_agent',
    version: 'latest',
    expected_url: 'https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/openstack/bosh-stemcell-latest-openstack-kvm-ubuntu-lucid-go_agent.tgz',
    expected_tar: 'bosh-stemcell-latest-openstack-kvm-ubuntu-lucid-go_agent.tgz'
  },
  {
    name: 'bosh-aws-xen-centos-go_agent',
    version: 'latest',
    expected_url: 'https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/aws/bosh-stemcell-latest-aws-xen-centos-go_agent.tgz',
    expected_tar: 'bosh-stemcell-latest-aws-xen-centos-go_agent.tgz'
  },
  {
    name: 'bosh-openstack-kvm-ubuntu-trusty-go_agent',
    version: 'latest',
    expected_url: 'https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/openstack/bosh-stemcell-latest-openstack-kvm-ubuntu-trusty-go_agent.tgz',
    expected_tar: 'bosh-stemcell-latest-openstack-kvm-ubuntu-trusty-go_agent.tgz'
  }].each do |s|
    describe "for #{s[:name]} with #{s[:version]} version" do
      let(:version) { s[:version] }
      let(:name) { s[:name] }

      describe '#download' do
        let(:expected_url) { s[:expected_url] }

        it 'should use the correct url' do
          expect(stemcell).to receive(:system)
          .with("wget --timeout=10 -q #{expected_url} -P ~/.deployer/stemcells")
          stemcell.download
        end
      end

      describe '#upload' do
        let(:expected_tar) { s[:expected_tar] }

        it 'should upload the correct tar' do
          expect(stemcell).to receive(:system)
            .with("bosh upload stemcell ~/.deployer/stemcells/#{expected_tar}")
          stemcell.upload
        end
      end
    end
  end
end
