require 'erb'
require 'bosh-deployer/stub'
require 'cancun'
require 'cancun/highline'

module Bosh; module Deployer; end ;end

class Bosh::Deployer::Stub
  include ::Cancun::Highline

  attr_reader :filename

  def initialize(path = '~/.bosh-deployer/stubs')
    path = path[0..-2] if path[-1] == '/'
    @filename = "#{path}/#{name}.yml"
  end

  def name
    raise NotImplementedError
  end

  def generate
    if File.exists?(filename) and !agree "#{filename} already exists, do you want to overwrite it?"
      say 'Stub generation cancelled!'
      return
    end

    save_stub
  end

  protected
  def save_stub
    stub.tap do |s|
      say "Saving stub at #{filename}"
      File.open(filename, 'w') { |f| f.write(s) }
    end
  end

  def template
    @template ||= ERB.new( File.read(File.expand_path("../../../stubs/#{name}.yml.erb", __FILE__)))
  end

  def stub
    say_bold "Provide the following information for #{name} configuration:"
    template.result(binding)
  end
end
