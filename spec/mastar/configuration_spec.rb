# coding: utf-8
require 'spec_helper'
describe Mastar::Configuration do
  context 'initialized without parameter' do# {{{
    before do
      @config = Mastar::Configuration.new
    end
    describe '#name' do
      it 'is :name' do
        @config.name.should be :name
      end
    end
    describe '#value' do
      it 'is :id' do
        @config.value.should be :id
      end
    end
    describe '#key' do
      it 'is nil' do
        @config.key.should be nil
      end
    end
  end# }}}

  context 'initialized with Hash parameters (name: title, value: value, key: uid)' do
    context 'key: symbol, value: symbol' do# {{{
      before do
        @config = Mastar::Configuration.new(:name => :title, :value => :value, :key => :uid)
      end
      describe '#name' do
        it 'is :title' do
          @config.name.should be :title
        end
      end
      describe '#value' do
        it 'is :value' do
          @config.value.should be :value
        end
      end
      describe '#key' do
        it 'is :uid' do
          @config.key.should be :uid
        end
      end
    end# }}}

    context 'key: symbol, value: string' do# {{{
      before do
        @config = Mastar::Configuration.new(:name => 'title', :value => 'value', :key => 'uid')
      end
      describe '#name' do
        it 'is :title' do
          @config.name.should be :title
        end
      end
      describe '#value' do
        it 'is :value' do
          @config.value.should be :value
        end
      end
      describe '#key' do
        it 'is :uid' do
          @config.key.should be :uid
        end
      end
    end# }}}

    context 'key: string, value: string' do# {{{
      before do
        @config = Mastar::Configuration.new('name' => 'title', 'value' => 'value', 'key' => 'uid')
      end
      describe '#name' do
        it 'is :title' do
          @config.name.should be :title
        end
      end
      describe '#value' do
        it 'is :value' do
          @config.value.should be :value
        end
      end
      describe '#key' do
        it 'is :uid' do
          @config.key.should be :uid
        end
      end
    end# }}}
  end

  context 'initialized with parameters (not Hash)' do# {{{
    before do
      @config = Mastar::Configuration.new(['title', 'value', 'uid'])
    end
    describe '#name' do
      it 'is :name' do
        @config.name.should be :name
      end
    end
    describe '#value' do
      it 'is :id' do
        @config.value.should be :id
      end
    end
    describe '#key' do
      it 'is nil' do
        @config.key.should be nil
      end
    end
  end# }}}
end
