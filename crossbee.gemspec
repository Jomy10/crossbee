Gem::Specification.new do |s|
  s.name        = 'crossbee'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "This is an example!"
  s.description = "Much longer explanation of the example!"
  s.authors     = ["Jonas Everaert"]
  s.files       = Dir["lib/**/*.rb"].push("bin/crossbee")
  s.bindir      = "bin"
  s.executables = ["crossbee"]
  s.require_paths = ["lib"]
  s.homepage    = 'https://rubygems.org/gems/example'
  s.metadata    = { "source_code_uri" => "https://github.com/example/example" }
  s.add_runtime_dependency "tty-command", "~> 0.10"
  s.add_runtime_dependency "workers", "~> 0.6"
end

