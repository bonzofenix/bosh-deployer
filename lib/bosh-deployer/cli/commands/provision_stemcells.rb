require 'yaml'

module Bosh; module Deployer; module Cli; module Commands; end; end; end; end

class Bosh::Deployer::Cli::Commands::ProvisionStemcells
  attr_reader :manifest_path
  def initialize(manifest_path =default_manifest_path )
    @manifest_path = manifest_path
  end

  def perform
    puts "Downloading #{stemcell.tar_filename} from bosh-jenkins-atifacts ..."
    stemcell.download
    puts 'uploading stemcell ...'
    stemcell.upload
  end

  protected
  def stemcell
    Bosh::Deployer::Stemcell.new(stemcell_name, stemcell_version)
  end

  def stemcell_name
    stemcell_conf['name']
  end

  def stemcell_version
    stemcell_conf['version']
  end

  def stemcell_conf
    manifest['resource_pools'][0]['stemcell']
  end

  def manifest
    ::YAML.load_file(manifest_path)
  end

  def default_manifest_path
    `bosh deployment`.scan(/.*`(.*)'/).first.first
  end
end
