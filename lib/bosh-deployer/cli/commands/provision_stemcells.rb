require 'yaml'

module Bosh; module Deployer; module Cli; module Commands; end; end; end; end

class Bosh::Deployer::Cli::Commands::ProvisionStemcells
  attr_reader :manifest_path

  def perform(manifest_path =default_manifest_path )
    @manifest_path = manifest_path
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
    manifest['meta']['stemcell']['name']
  end

  def stemcell_version
    manifest['meta']['stemcell']['version']
  end

  def manifest
    ::YAML.load_file(manifest_path)
  end

  def default_manifest_path
    `bosh deployment`.scan(/.*`(.*)'/).first.first
  end

end
