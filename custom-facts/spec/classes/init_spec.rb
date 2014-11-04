require 'spec_helper'
describe 'facts' do

  context 'with defaults for all parameters' do
    it { should contain_class('facts') }
  end
end
