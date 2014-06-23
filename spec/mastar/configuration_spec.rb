# coding: utf-8
require 'spec_helper'
describe Mastar::Configuration do
  context 'initialized without parameter' do
    let(:config) { Mastar::Configuration.new }
    subject { config }
    it { expect(config.name).to be :name }
    it { expect(config.value).to be :id }
    it { expect(config.key).to be_nil }
  end

  context 'initialized with Hash parameters (name: title, value: value, key: uid)' do
    context 'key: symbol, value: symbol' do
      let(:config) { Mastar::Configuration.new(:name => :title, :value => :value, :key => :uid) }
      subject { config }
      it { expect(config.name).to be :title }
      it { expect(config.value).to be :value }
      it { expect(config.key).to be :uid }
    end

    context 'key: symbol, value: string' do
      let(:config) { Mastar::Configuration.new(:name => 'title', :value => 'value', :key => 'uid') }
      subject { config }
      it { expect(config.name).to be :title }
      it { expect(config.value).to be :value }
      it { expect(config.key).to be :uid }
    end

    context 'key: string, value: string' do
      let(:config) { Mastar::Configuration.new('name' => 'title', 'value' => 'value', 'key' => 'uid') }
      subject { config }
      it { expect(config.name).to be :title }
      it { expect(config.value).to be :value }
      it { expect(config.key).to be :uid }
    end
  end

  context 'initialized with parameters (not Hash)' do
    let(:config) { Mastar::Configuration.new(['title', 'value', 'uid']) }
    subject { config }
    it { expect(config.name).to be :name }
    it { expect(config.value).to be :id }
    it { expect(config.key).to be_nil }
  end
end
