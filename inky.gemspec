Gem::Specification.new do |s|
  s.name        = 'inky'
  s.version     = '0.0.0'
  s.date        = '2016-02-12'
  s.summary     = 'Inky coming!'
  s.description = 'Inky coming!'
  s.authors     = ["Kevin Ball"]
  s.email       = 'kball@zurb.com'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
end
