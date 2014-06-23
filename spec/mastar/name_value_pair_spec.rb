# coding: utf-8
require 'spec_helper'
describe Mastar::NameValuePair do
  context 'initialized with name and value' do
    let(:pair) { Mastar::NameValuePair.new('label', 1) }
    it { expect(pair.name).to eq 'label' }
    it { expect(pair.value).to eq 1 }
    it { expect(pair.first).to eq pair.name }
    it { expect(pair.last).to eq pair.value }
  end
end
