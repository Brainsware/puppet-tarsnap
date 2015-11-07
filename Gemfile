source 'https://rubygems.org'

group :test do
  gem 'rake'
  gem 'puppet', ENV['PUPPET_VERSION'] || '~> 3.8.0'
  gem 'rspec-puppet', git: 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-augeas'
  gem 'ruby-augeas'
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'
  gem 'rspec-puppet-facts'
  gem 'rspec'
  gem 'puppet-blacksmith'
  gem 'rubocop'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-version_comparison-check'
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-variable_contains_upcase'
end

group :development do
  gem 'travis'
  gem 'travis-lint'
  gem 'guard-rake'
end

