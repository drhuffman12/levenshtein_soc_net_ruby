# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'levenshtein_soc_net_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "levenshtein_soc_net_ruby"
  spec.version       = LevenshteinSocNetRuby::VERSION
  spec.authors       = ["Daniel Huffman"]
  spec.email         = ["drhuffman12@yahoo.com"]

  spec.summary       = %q{Levenshtein Social Network (Ruby implementation)}
  spec.description   = %q{Calculate the 'social network' quantity for a group of words based on their Levenshtein Distance and Letter Histograms.}
  spec.homepage      = "https://github.com/drhuffman12/levenshtein_soc_net_ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
