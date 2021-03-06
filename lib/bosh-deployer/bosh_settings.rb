require 'bosh-deployer/microbosh_settings'

module Bosh::Deployer::BoshSettings
  def microbosh
    @microbosh ||= Bosh::Deployer::MicroboshSettings.load
  end

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

  def static_ip_from
    @static_ip_from ||= ask 'Intial available static ip for deployment:'
  end

  def static_ip_to
    @static_ip_to ||= ask 'Last available static ip for deployment:'
  end

  def openstack_auth_url
    @openstack_auth_url ||= ask('Openstack auth url:') do |q|
      q.default = microbosh.provider.credentials.openstack_auth_url.gsub('/tokens', '') if microbosh
    end
  end

  def openstack_username
    @openstack_username ||= ask('Openstack username:') do |q|
      q.default =  microbosh.provider.credentials.openstack_username if microbosh
    end
  end

  def openstack_api_key
    @openstack_api_key ||= ask('Openstack api key:') do |q|
      q.default =  microbosh.provider.credentials.openstack_api_key if microbosh
    end
  end

  def openstack_tenant
    @openstack_tenant ||= ask('Openstack tenant:') do |q|
      q.default =  microbosh.provider.credentials.openstack_tenant if microbosh
    end
  end

  def recursor_ip
    @recursor_ip ||= ask('Recursor ip or host:') do |q|
      q.default = microbosh.address.ip if microbosh
    end
  end

  def subnet_id
    @subnet_id ||= ask('Subnet ID where it will be deployed:') do |q|
      q.default = microbosh.address.subnet_id if microbosh
    end
  end

  def gateway
    @gateway ||= ask('Gateway IP:') do |q|
      #UGLY REPLACE ME WITH A REGEX
      q.default = (static_ip_from.split('.')[0..-2] + ['1']).join('.')
    end
  end

  def range
    @range ||= ask('Ip Range where it will be deployed:') do |q|
      #UGLY REPLACE ME WITH A REGEX
      q.default = (static_ip_from.split('.')[0..-2] + ['0']).join('.') + '/24'
    end
  end

end
