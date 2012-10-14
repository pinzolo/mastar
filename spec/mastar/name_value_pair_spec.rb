# coding: utf-8
require 'spec_helper'
describe Mastar::NameValuePair do
  context 'initialized with name and value' do
    before do
      @pair = Mastar::NameValuePair.new('label', 1)
    end
    describe '#name' do
      it 'is label' do
        @pair.name.should eq 'label'
      end
    end
    describe '#value' do
      it 'is 1' do
        @pair.value.should eq 1
      end
    end
    describe '#first' do
      it 'is equal #name' do
        @pair.first.should eq @pair.name
      end
    end
    describe '#last' do
      it 'is equal #value' do
        @pair.last.should eq @pair.last
      end
    end
  end
end
