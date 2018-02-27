
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "book_releases_cli_app/version"

Gem::Specification.new do |spec|
  spec.name          = "book_releases_cli_app"
  spec.version       = BookReleasesCliApp::VERSION
  spec.authors       = ["Ni Chia"]
  spec.email         = ["nichia@gmail.com"]

  spec.summary       = %q{Upcoming Book Releases}
  spec.description   = %q{Book_Releases_Cli_App lists upcoming book releases by "Barnes and Noble" and "Books a Million" stores.}
  spec.homepage      = "https://github.com/nichia/book_releases_cli_app.git"
  spec.license       = "MIT"

  spec.files         = [
    "lib/book_releases_cli_app/book.rb",
    "lib/book_releases_cli_app/cli.rb",
    "lib/book_releases_cli_app/scraper.rb",
    "lib/book_releases_cli_app/store.rb",
    "lib/book_releases_cli_app/version.rb",
    "lib/book_releases_cli_app.rb",
    "config/environment.rb"
    ]
  spec.bindir        = "bin"
  spec.executables   = ["book-releases"]
  spec.require_paths = ["lib", "lib/book_releases_cli_app"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_development_dependency "nokogiri"
  spec.add_runtime_dependency "colorize", "~> 0.8.1"
end
