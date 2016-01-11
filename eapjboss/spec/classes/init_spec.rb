require 'spec_helper'
describe 'eapjboss' do

  context 'with defaults for all parameters' do
    it { should contain_class('eapjboss') }
  end
end
