source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem 'puppetlabs_spec_helper', '~> 1.2.2',                         :require => false
  gem 'rspec-puppet',                                               :require => false, :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts',                                         :require => false
  gem 'rspec-puppet-utils',                                         :require => false
  gem 'puppet-lint-absolute_classname-check',                       :require => false
  gem 'puppet-lint-leading_zero-check',                             :require => false
  gem 'puppet-lint-trailing_comma-check',                           :require => false
  gem 'puppet-lint-version_comparison-check',                       :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  :require => false
  gem 'puppet-lint-unquoted_string-check',                          :require => false
  gem 'puppet-lint-variable_contains_upcase',                       :require => false
  gem 'metadata-json-lint',                                         :require => false
  gem 'puppet-blacksmith',                                          :require => false
  gem 'voxpupuli-release',                                          :require => false, :git => 'https://github.com/voxpupuli/voxpupuli-release-gem.git'
  gem 'puppet-strings', '0.4.0',                                    :require => false
  gem 'rubocop-rspec', '~> 1.6',                                    :require => false if RUBY_VERSION >= '2.3.0'
end

group :development do
  gem 'travis',       :require => false
  gem 'travis-lint',  :require => false
  gem 'guard-rake',   :require => false
end


if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, :require => false, :groups => [:test]
else
  gem 'facter', :require => false, :groups => [:test]
end

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 4.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
