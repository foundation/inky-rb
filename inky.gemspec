lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inky/rails/version'

Gem::Specification.new do |s|
  s.name        = 'inky-rb'
  s.version     = Inky::Rails::VERSION
  s.summary     = 'Inky is an HTML-based templating language that converts simple HTML into complex, responsive email-ready HTML. Designed for Foundation for Emails, a responsive email framework from ZURB.  '
  s.description = 'Inky is an HTML-based templating language that converts simple HTML into complex, responsive email-ready HTML. Designed for Foundation for Emails, a responsive email framework from ZURB.  '
  s.authors     = ["ZURB"]
  s.email       = ['foundation@zurb.com']
  s.homepage    = 'https://github.com/zurb/inky-rb'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "foundation_emails", "~> 2"
  s.add_dependency "nokogiri"
  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
end
