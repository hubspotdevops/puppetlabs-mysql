require 'spec_helper'
describe 'hsmysql::server::monitor' do
  let :facts do
    { :osfamily => 'Debian' }
  end
  let :pre_condition do
    "include 'hsmysql::server'"
  end
  let :params do
    {
      :mysql_monitor_username => 'monitoruser',
      :mysql_monitor_password => 'monitorpass',
      :mysql_monitor_hostname => 'monitorhost'
    }
  end

  it { should contain_database_user("monitoruser@monitorhost")}
end
