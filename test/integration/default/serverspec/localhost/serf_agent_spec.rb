require 'spec_helper'

describe command('serf members -format=json') do
  its(:stdout) { should match /netcalc/ }
  its(:stdout) { should match /0.1.0-rc.1/ }
end
