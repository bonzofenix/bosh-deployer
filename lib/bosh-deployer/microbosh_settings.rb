require 'yaml'
require 'recursive-open-struct'

class Bosh::Deployer::MicroboshSettings < RecursiveOpenStruct
  attr_reader :filepath

  def initialize(h=nil, args={})
    if h && h.is_a?(String)
      @filepath ||= h
      super(YAML.load_file(filepath)) if File.exists?(filepath)
    else
      @filepath ||= '~/.bootstrap/settings.yml'
      super(h, args)
    end
  end

  def self.load(filepath = nil)
    new(filepath).tap do |settings|
      return unless settings.to_a
    end
  end
end
