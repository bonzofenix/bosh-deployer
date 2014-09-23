require 'yaml'


class Hash
  def sort_by_key(recursive = false, &block)
    self.keys.sort(&block).reduce({}) do |seed, key|
      seed[key] = self[key]
      if recursive && seed[key].is_a?(Hash)
        seed[key] = seed[key].sort_by_key(true, &block)
      end
      seed
    end
  end
end

def equal_yaml(expected_file, actual_file)
  @expected_content = File.read(expected_file)
  @actual_content = File.read(actual_file)

  expected = YAML.load(@expected_content).sort_by_key(true).to_a
  actual = YAML.load(@actual_content).sort_by_key(true).to_a

  expect(expected).to eq(actual)
end
