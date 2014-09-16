require 'erb'
require 'cancun/highline'
require 'readwritesettings'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::BoshStub
  include ::Cancun::Highline
  attr_reader :filename

  def initialize(path = '~/.bosh-deployer/stubs')
    path = path[0..-2] if path[-1] == '/'
    @filename = "#{path}/bosh.yml"
  end

  def generate
    say_bold 'Provide the following information for your bosh configuration:'
    stub = template.result(binding)
    say "Saving stub at #{filename}"
    File.open(filename, 'w') { |f| f.write(stub) }
  end

  def static_ip_from
    @static_ip_from ||= ask 'Intial available static ip for deploying bosh:'
  end

  def static_ip_to
    @static_ip_to ||= ask 'Last available static ip for deploying bosh:'
  end


  def openstack_auth_url
    @openstack_auth_url ||= ask('Openstack auth url:') do |q|
      q.default =  microbosh.provider.credentials.openstack_auth_url.gsub('/tokens', '')
    end
  end

  def openstack_username
    @openstack_username ||= ask('Openstack username:') do |q|
      q.default =  microbosh.provider.credentials.openstack_username
    end
  end

  def openstack_api_key
    @openstack_api_key ||= ask('Openstack api key:') do |q|
      q.default =  microbosh.provider.credentials.openstack_api_key
    end
  end

  def openstack_tenant
    @openstack_tenant ||= ask('Openstack tenant:') do |q|
      q.default =  microbosh.provider.credentials.openstack_tenant
    end
  end

  def recursor_ip
    @recursor_ip ||= ask('Recursor ip or host:') do |q|
      q.default = microbosh.address.ip
    end
  end

  def subnet_id
    @subnet_id ||= ask('Subnet ID where bosh will be deployed:') do |q|
      q.default = microbosh.address.subnet_id
    end
  end

  def gateway
    @gateway ||= ask('Gateway IP for bosh:') do |q|
      #UGLY REPLACE ME WITH A REGEX
      q.default = (static_ip_from.split('.')[0..-2] + ['1']).join('.')
    end
  end

  def range
    @range ||= ask('Gateway IP for bosh:') do |q|
      #UGLY REPLACE ME WITH A REGEX
      q.default = (static_ip_from.split('.')[0..-2] + ['0']).join('.') + '/24'
    end
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

  protected

  def template
    @template ||= ERB.new(File.read('stubs/bosh.yml.erb'))
  end

  def microbosh
    @microbosh ||= ReadWriteSettings.new('~/.bootstrap/settings.yml')
  end
end