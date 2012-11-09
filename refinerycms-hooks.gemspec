# Encoding: UTF-8

Gem::Specification.new do |s|
  s.author            = "Andrew Hadinyoto"
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-hooks'
  s.version           = '0.0'
  s.description       = 'Ruby on Rails Hooks extension for Refinery CMS'
  s.date              = '2012-09-26'
  s.summary           = 'Hooks extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.8'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.8'
end
