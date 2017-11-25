gem_source = if ENV['GEM_SOURCE'].nil?
               'http://rubygems.org'
             else
               ENV['GEM_SOURCE']
             end

source gem_source

group :test do
  gem 'metadata-json-lint',                                         :require => false
  gem 'puppet-blacksmith',                                          :require => false
  gem 'puppet-lint-absolute_classname-check',                       :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  :require => false
  gem 'puppet-lint-leading_zero-check',                             :require => false
  gem 'puppet-lint-trailing_comma-check',                           :require => false
  gem 'puppet-lint-unquoted_string-check',                          :require => false
  gem 'puppet-lint-variable_contains_upcase',                       :require => false
  gem 'puppet-lint-version_comparison-check',                       :require => false
  gem 'puppet-strings', '~> 1.0.0',                                 :require => false
  gem 'puppetlabs_spec_helper', '~> 1.2.2',                         :require => false
  gem 'rspec-puppet',                                               :require => false, :git => 'http://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts',                                         :require => false
  gem 'rspec-puppet-utils',                                         :require => false
  gem 'rubocop-rspec', '~> 1.6',                                    :require => false if RUBY_VERSION >= '2.3.0'
  gem 'voxpupuli-release',                                          :require => false, :git => 'http://github.com/voxpupuli/voxpupuli-release-gem.git'
end

group :development do
  gem 'guard-rake',   :require => false
  gem 'travis',       :require => false
  gem 'travis-lint',  :require => false
end

facterversion = if ENV['FACTER_GEM_VERSION'].nil?
                  '~> 2.5'
                else
                  ENV['FACTER_GEM_VERSION']
                end

gem 'facter', facterversion.to_s, :require => false, :groups => [:test]

puppetversion = if ENV['PUPPET_VERSION'].nil?
                  '~> 4.0'
                else
                  ENV['PUPPET_VERSION'].to_s
                end

gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
