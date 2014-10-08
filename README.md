bosh-deployer
=============

[![Build Status](https://travis-ci.org/bonzofenix/bosh-deployer.svg?branch=master)](https://travis-ci.org/bonzofenix/bosh-deployer)
[![Code Climate](https://codeclimate.com/github/bonzofenix/bosh-deployer.png)](https://codeclimate.com/github/bonzofenix/bosh-deployer)
[![Coverage Status](https://coveralls.io/repos/bonzofenix/bosh-deployer/badge.png)](https://coveralls.io/r/bonzofenix/bosh-deployer)
[![Dependency Status](https://gemnasium.com/bonzofenix/bosh-deployer.svg)](https://gemnasium.com/bonzofenix/bosh-deployer)


Tired of repeting yourself all the time when using bosh? Here are a couple of tools that can help you when working with bosh.

## Installation

    $ gem install bosh-deployer

## Usage

```:bash
  |2.1.2| in ~/workspace/bosh-deployer
  ± am |master ✓| → bosh deployer
  bosh deployer sub-commands:
  
  deployer
      show deployer sub-commands
  
  deployer provision stemcells
      finds and uploads the required stemcell point out in your manifest to bosh
  
  deployer generate stub <name> [<path>]
      Creates stub file to be compile with Spiff.
  
  deployer target <name> [<filepath>]
      Targets bosh or microbosh from a deployment.yml, stub.yml or bosh-bootstrap microbosh settings.yml

```

## Contributing

1. Fork it ( https://github.com/bonzofenix/bosh-deployer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
