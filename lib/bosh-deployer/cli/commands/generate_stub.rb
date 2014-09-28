
module Bosh; module Deployer; module Cli; module Commands; end; end; end; end

class Bosh::Deployer::Cli::Commands::GenerateStub
  attr_reader :name, :path

  def initialize(name, path=nil)
    @name = name
    @path = path
  end

  def perform
    stub.generate
  end

  protected
  def stub
    case name
      when 'bosh'
        Bosh::Deployer::BoshStub.new(path)
      when 'cf'
        Bosh::Deployer::CFStub.new(path)
    end
  end
end
