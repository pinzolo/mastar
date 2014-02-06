# coding: utf-8
require 'spec_helper'
def pair_map(pairs)
  pairs.inject({}) do |result, item|
    result[item.value] = item.name
    result
  end
end

describe Mastar do
  describe "class methods" do
    describe '.pairs' do
      context 'default' do
        context 'directly called' do
          before do
            @all_dows = Dow1.all
          end
          it 'defined' do
            defined?(Dow1.pairs).should be_true
          end
          context 'without option argument' do
            it 'respond to :first' do
              Dow1.pairs.all? { |pair| pair.respond_to?(:first) }.should be_true
            end
            it 'respond to :last' do
              Dow1.pairs.all? { |pair| pair.respond_to?(:last) }.should be_true
            end
            it 'get all rows' do
              pairs = pair_map(Dow1.pairs)
              @all_dows.all? { |dow| pairs[dow.id] == dow.name }.should be_true
            end
          end
          context 'with option argument(:name => :short_name, :value => :name)' do# {{{
            context 'key: Symbol, value: Symbol' do
              it 'get specified columns by option' do
                pairs = pair_map(Dow1.pairs(:name => :short_name, :value => :name))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: String, value: Symbol' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs('name' => :short_name, 'value' => :name))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: Symbol, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs(:name => 'short_name', :value => 'name'))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
            context 'key: String, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs('name' => 'short_name', 'value' => 'name'))
                @all_dows.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
              end
            end
          end# }}}
          context 'with nil argument' do
            it 'same as no option' do
              pairs = pair_map(Dow1.pairs)
              @all_dows.all? { |dow| pairs[dow.id] == dow.name }.should be_true
            end
          end
        end
        context 'called by way of ARel' do
          it 'respond' do
            Dow1.holiday.respond_to?(:pairs).should be_true
          end
          it 'get filtered rows' do
            pairs = pair_map(Dow1.holiday.pairs)
            Dow1.where(:holiday => true).all? { |dow| pairs[dow.id] == dow.name }.should be_true
          end
        end
      end
      context 'use mastar_name method' do
        it 'use mastar_name attr as name' do
          pairs = pair_map(Dow3.pairs)
          Dow3.all.all? { |dow| pairs[dow.id] == dow.short_name }.should be_true
        end
      end
      context 'use mastar_value method' do
        it 'use mastar_value attr as value' do
          pairs = pair_map(Dow2.pairs)
          Dow2.all.all? { |dow| pairs[dow.short_name] == dow.name }.should be_true
        end
      end
    end
    describe 'define direct class method' do
      context 'no argument' do
        it 'get record object' do
          Dow1.respond_to?(:sunday).should be_false
          Dow1.sunday.is_a?(Dow1).should be_true
          Dow1.respond_to?(:sunday).should be_true
          Dow1.sunday.name.should eq 'sunday'
        end
      end
      context 'with 1 argument' do
        it 'get attribute value at direct' do
          Dow1.monday(:short_name).should eq 'Mon.'
        end
      end
      context 'with multiple arguments' do
        it 'get Array of attribute values at a time' do
          Dow1.tuesday(:short_name, :holiday).is_a?(Array).should be_true
          short_name, name = Dow1.wednesday(:short_name, :name)
          short_name.should eq 'Wed.'
          name.should eq 'wednesday'
        end
      end
      context 'mastar.key is not set' do
        it 'raise NoMethodError' do
          lambda { Dow2.monday }.should raise_error(NoMethodError)
        end
      end
    end
    describe 'not exist in key column' do
      context 'no argument' do
        it 'get nil' do
          Dow1.foo.should be_nil
        end
      end
      context 'with 1 argument' do
        it 'get nil' do
          Dow1.bar(:name).should be_nil
        end
      end
      context 'with multiple arguments' do
        it 'get nil' do
          Dow1.baz(:name, :value).should be_nil
        end
      end
    end
    describe '.mastar multiple setting' do
      context 'mastar#name, mastar#value' do
        it '.pairs method works' do
          pairs = pair_map(Dow4.pairs)
          Dow4.all.all? { |dow| pairs[dow.name] == dow.short_name }.should be_true
        end
      end
      context 'mastar#key' do
        it 'direct class method defining works' do
          Dow4.respond_to?(:sunday).should be_false
          Dow4.sunday.is_a?(Dow4).should be_true
          Dow4.respond_to?(:sunday).should be_true
          Dow4.sunday.name.should eq 'sunday'
        end
      end
    end
    describe '.get' do
      context 'called by cached id' do
        it 'get cached record' do
          rec = Dow4.wednesday
          rec.respond_to?(:iii).should be_false
          class << rec
            def iii
              'iii'
            end
          end
          Dow4.get(4).respond_to?(:iii).should be_true
        end
      end
      context 'called by uncached id' do
        it 'get new record and cache' do
          recs = Dow4.__send__(:mastar_records)
          recs[5].should be_nil
          Dow4.get(5)
          recs = Dow4.__send__(:mastar_records)
          recs[5].should_not be_nil
        end
      end
    end
  end
  describe "instance methods" do
    context 'record update' do
      it 'direct method record is updated automatically' do
        Dow1.friday.holiday?.should eq false
        fri = Dow1.find(Dow1.friday.id)
        fri.holiday = true
        fri.save
        Dow1.friday.holiday?.should eq true
      end
    end
  end
end
