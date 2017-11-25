require 'spec_helper.rb'

describe 'tarsnap::periodic', :type => :define do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        let(:pre_condition) { 'include ::tarsnap' }

        let(:title) { 'etc' }
        let(:params) do
          {
            'ensure' => 'present',
            'dirs'   => ['/etc /opt/etc /usr/local/etc'],
          }
        end

        it do
          is_expected.to contain_cron('tarsnap-etc-keep')
            .with(ensure: 'present')
            .with(command: '/usr/local/bin/tarsnap-rotate etc 30')
        end
      end
    end
  end
end
