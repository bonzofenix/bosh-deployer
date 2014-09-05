module Bosh; module Deployer; end ;end

class Bosh::Deployer::Stemcell
  attr_reader :name, :version, :default_path
  def initialize(name, version, default_path = '~/.deployer/stemcells')
    @name = name
    @version = version
    @default_path = default_path
  end

  def download
    system("wget --timeout=10 -q #{url} -P #{default_path}")
  end
  def upload
    system("bosh upload stemcell #{default_path}/#{tar_filename}")
  end

  def tar_filename
    if os != 'centos'
      "bosh-stemcell-#{version}-#{cloud}-#{virtualization_type}-#{os}-#{os_version}-go_agent.tgz"
    else
      "bosh-stemcell-#{version}-#{cloud}-#{virtualization_type}-#{os}-go_agent.tgz"
    end
  end

  private
  def url
    "https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/#{cloud}/#{tar_filename}"
  end

  def cloud
    name_attrs[1]
  end

  def virtualization_type
    name_attrs[2]
  end

  def os
    name_attrs[3]
  end

  def os_version
    name_attrs[4]
  end

  def name_attrs
    @name_attrs ||= name.split('-')
  end
end


