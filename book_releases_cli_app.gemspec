
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "book_releases_cli_app/version"

Gem::Specification.new do |spec|
  spec.name          = "book_releases_cli_app"
  spec.version       = BookReleasesCliApp::VERSION
  spec.authors       = ["'Ni Chia'"]
  spec.email         = ["'nichia@gmail.com'"]

  spec.summary       = %q{Upcoming Book Releases}
  spec.description   = %q{Book_Releases_Cli_App lists upcoming book releases by "Barnes and Noble" and "Books a Million" stores.}
  spec.homepage      = "https://github.com/nichia/book_releases_cli_app.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_development_dependency "nokogiri"
  spec.add_runtime_dependency "colorize", "~> 0.8.1"
end
