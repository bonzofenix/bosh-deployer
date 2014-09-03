# Copyright (c) 2012-2013 Stark & Wayne, LLC

require "bosh-deployer/cli/commands/provision_stemcells"

describe Bosh::Deployer::Cli::Commands::ProvisionStemcells do
  let(:cmd) { described_class.new }

  describe '#perform' do

    describe 'when when filename is provided'  do
    it 'should download stemcell to ~/.deployer/stemcells/stemcell_name'
    it 'should upload stemcell to targeted bosh'
    end

    describe 'when when filename is not provided'  do
      describe 'when deployment is target ' do
        it 'should use the target deployment manifest'
      end

      it 'should raise error with missing arguments' do
      end
    end
  end
end
