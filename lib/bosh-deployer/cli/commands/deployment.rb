require 'yaml'
module Bosh; module Deployer; module Cli; module Commands; end; end; end; end

class Bosh::Deployer::Cli::Commands::Deployment
  attr_reader :name

  def initialize(name, filepath=nil)
    @name = name
    @filepath = filepath
  end

  def target
    puts `bosh target #{address}`
  end

  def address
    case name
    when 'microbosh'
      yml['address']['ip']
    when 'bosh'
      yml['meta']['networks']['manual']['static'][0].split('-')[0].strip
    end
  end

  def yml
    YAML.load_file(filepath)
  end

  def filepath
    return @filepath if @filepath
    @filepath = case name
                when 'microbosh'
                  "#{ENV['HOME']}/.microbosh/settings.yml"
                when 'bosh'
                  "#{ENV['HOME']}/.deployer/stubs/bosh.yml"
                end
  end
end
