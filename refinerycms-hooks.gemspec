# Encoding: UTF-8

Gem::Specification.new do |s|
  s.author            = "Andrew Hadinyoto"
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-hooks'
  s.version           = '0.1'
  s.description       = 'Ruby on Rails Hooks extension for Refinery CMS'
  s.date              = '2012-11-17'
  s.summary           = 'Add simple markup {{tag}} to Refinery CMS Page'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.textile"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.8'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.8'
end
