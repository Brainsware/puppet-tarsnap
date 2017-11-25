require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-strings/tasks'

if RUBY_VERSION >= '2.3.0'
  require 'rubocop/rake_task.rb'
  RuboCop::RakeTask.new
end

PuppetLint.configuration.relative = true
PuppetLint.configuration.log_format = '%<path>s:%<linenumber>s:%<check>s:%<KIND>s:%<message>s'
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_relative_classname_inclusion')

# Forsake support for Puppet 2.6.2 for the benefit of cleaner code.
# http://puppet-lint.com/checks/class_parameter_defaults/
PuppetLint.configuration.send('disable_class_parameter_defaults')
# http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')

exclude_paths = [
  'pkg/**/*',
  'vendor/**/*',
  'spec/**/*',
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc 'Run acceptance tests'
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

desc 'Run metadata_lint, lint, syntax, and spec tests.'
task test: %I[
  metadata_lint
  lint
  syntax
  spec
]

Blacksmith::RakeTask.new do |t|
  t.build = false # do not build the module nor push it to the Forge
  # just do the tagging [:clean, :tag, :bump_commit]
end

desc 'Offload release process to Travis.'
task travis_release: [
  :check_changelog,  # check that the changelog contains an entry for the current release
  :"module:release", # do everything except build / push to forge, travis will do that for us
]

desc 'Check Changelog.'
task :check_changelog do
  v = Blacksmith::Modulefile.new.version
  if File.readlines('CHANGELOG.md').grep(/Releasing v#{v}/).size.zero?
    raise "Unable to find a CHANGELOG.md entry for the #{v} release."
  end
end
