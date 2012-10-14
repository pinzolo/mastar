# coding: utf-8
require 'spec_helper'
def pair_map(pairs)
  pairs.inject({}) do |result, item|
    result[item.value] = item.name
    result
  end
end

describe Mastar do
  describe Mastar::ClassMethods do
    describe '.pairs' do
      context 'default' do
        context 'directly called' do
          before do
            @all_dows = Dow.all
          end
          it 'defined' do
            defined?(Dow.pairs).should be_true
          end
          context 'without option argument' do
            it 'respond to :first' do
              Dow.pairs.all? { |pair| pair.respond_to?(:first) }.should be_true
            end
            it 'respond to :last' do
              Dow.pairs.all? { |pair| pair.respond_to?(:last) }.should be_true
            end
            it 'get all rows' do
              pairs = pair_map(Dow.pairs)
              @all_dows.all? { |dow| pairs[dow.id] == dow.name }.should be_true
            end
          end
          context 'with option argument(:name => :short_name, :value => :name)' do# {{{
            context 'key: Symbol, value: Symbol' do
              it 'get specified columns by option' do
                pairs = pair_map(Dow.pairs(:name => :short_name, :value => :name))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: String, value: Symbol' do
              it 'same as above' do
                pairs = pair_map(Dow.pairs('name' => :short_name, 'value' => :name))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: Symbol, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow.pairs(:name => 'short_name', :value => 'name'))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: String, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow.pairs('name' => 'short_name', 'value' => 'name'))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
          end# }}}
          context 'with nil argument' do
            it 'same as no option' do
              pairs = pair_map(Dow.pairs)
              @all_dows.all? { |dow| pairs[dow.id] == dow.name }.should be_true
            end
          end
        end
        context 'called by way of ARel' do
          it 'respond' do
            Dow.holiday.respond_to?(:pairs).should be_true
          end
          it 'get filtered rows' do
            pairs = pair_map(Dow.holiday.pairs)
            Dow.where(:holiday => true).all? { |dow| pairs[dow.id] == dow.name }.should be_true
          end
        end
      end
      context 'use mastar_name method' do
        it 'use mastar_name attr as name' do
          pairs = pair_map(Month.pairs)
          Month.all.all? { |month| pairs[month.id] == month.short_name }.should be_true
        end
      end
      context 'use mastar_value method' do
        it 'use mastar_value attr as value' do
          pairs = pair_map(Color.pairs)
          Color.all.all? { |color| pairs[color.rgb] == color.name }.should be_true
        end
      end
    end

  end
  describe Mastar::InstanceMethods do

  end
end
