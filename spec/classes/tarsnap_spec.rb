require 'spec_helper.rb'

describe 'tarsnap', :type => :class do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to contain_package('tarsnap').with(ensure: 'present') }

        if facts[:kernel] == 'FreeBSD'
          sysconf  = '/usr/local/etc'
          cachedir = '/usr/local/tarsnap-cache'
          group    = 'wheel'
        elsif facts[:kernel] == 'Linux'
          sysconf  = '/etc'
          cachedir = '/var/backups/tarsnap'
          group    = 'root'
        end

        it do
          is_expected.to contain_file("#{sysconf}/tarsnap.conf").with(
            ensure: 'file',
            mode:   '0644',
            owner:  'root',
            group:  group,
          )
        end
        it do
          is_expected.to contain_file(cachedir).with(
            ensure: 'directory',
            mode:   '0700',
            owner:  'root',
            group:  group,
          )
        end
      end
    end
  end

  context 'creating a batch process' do
    _os, facts = on_supported_os.first
    let(:facts) do
      facts
    end

    let(:params) do
      {
        :locations => {
          'etc'      => ['/etc/', '/usr/local/etc', '/opt/etc'],
          'home'     => ['/home/me/src', '/home/me/pix'],
          'dotfiles' => ['/home/me/.ssh', '/home/me/.config'],
        }
      }
    end
    it do
      is_expected.to contain_file('/usr/local/bin/tarsnap-batch').with(
        'ensure' => 'file',
        'mode'   => '0755',
      )
    end
    it do
      is_expected.to contain_file('/usr/local/bin/tarsnap-batch').with_content(
        %r{.*  /usr/local/etc \\\n.*}
      )
    end
  end
end
