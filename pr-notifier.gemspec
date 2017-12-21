
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pr-notifier/version"

Gem::Specification.new do |spec|
  spec.name          = "pr-notifier"
  spec.version       = PrNotifier::VERSION
  spec.authors       = ["hatappi"]
  spec.email         = ["hatappi@hatappi.me"]

  spec.summary       = "notify GitHub PR in slack"
  spec.description   = "notify GitHub PR in slack"
  spec.homepage      = "https://github.com/hatappi/pr-notifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'octokit'
  spec.add_dependency 'slack-notifier'
  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
