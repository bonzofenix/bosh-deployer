module Bosh::Deployer::MicroboshSettings
  def default_key_name
    @default_key_name ||= ask('Key name:') do |q|
      q.default = 'firstbosh'
    end
  end

  def private_key
    @private_key ||= ask('Private key:') do |q|
      q.default = '~/.microbosh/ssh/firstbosh.pem'
    end
  end

  def microbosh
    if File.exists?('~/.bootstrap/settings.yml')
      @microbosh ||= ReadWriteSettings.new('~/.bootstrap/settings.yml')
    end
  end
end
