source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 4.8.0'
  gem "rspec-puppet", '~> 2.5'
  gem "puppetlabs_spec_helper", '~> 1.2.2'
  gem "metadata-json-lint"
  gem "rspec-puppet-facts"
  gem "rspec"
  gem "rubocop"
  gem "puppet-blacksmith"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "guard-rake"
end
