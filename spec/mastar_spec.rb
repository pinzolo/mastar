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
          let(:all_dows) { Dow1.all }
          it 'defined' do
            expect(defined?(Dow1.pairs)).to be_truthy
          end
          context 'without option argument' do
            it 'respond to :first' do
              expect(Dow1.pairs.all? { |pair| pair.respond_to?(:first) }).to eq true
            end
            it 'respond to :last' do
              expect(Dow1.pairs.all? { |pair| pair.respond_to?(:last) }).to eq true
            end
            it 'get all rows' do
              pairs = pair_map(Dow1.pairs)
              expect(all_dows.all? { |dow| pairs[dow.id] == dow.name }).to eq true
            end
          end
          context 'with option argument(:name => :short_name, :value => :name)' do# {{{
            context 'key: Symbol, value: Symbol' do
              it 'get specified columns by option' do
                pairs = pair_map(Dow1.pairs(:name => :short_name, :value => :name))
                expect(all_dows.all? { |dow| pairs[dow.name] == dow.short_name }).to eq true
              end
            end
            context 'key: String, value: Symbol' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs('name' => :short_name, 'value' => :name))
                expect(all_dows.all? { |dow| pairs[dow.name] == dow.short_name }).to eq true
              end
            end
            context 'key: Symbol, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs(:name => 'short_name', :value => 'name'))
                expect(all_dows.all? { |dow| pairs[dow.name] == dow.short_name }).to eq true
              end
            end
            context 'key: String, value: String' do
              it 'same as above' do
                pairs = pair_map(Dow1.pairs('name' => 'short_name', 'value' => 'name'))
                expect(all_dows.all? { |dow| pairs[dow.name] == dow.short_name }).to eq true
              end
            end
          end# }}}
          context 'with nil argument' do
            it 'same as no option' do
              pairs = pair_map(Dow1.pairs)
              expect(all_dows.all? { |dow| pairs[dow.id] == dow.name }).to eq true
            end
          end
        end
        context 'called by way of ARel' do
          it 'respond' do
            expect(Dow1.holiday.respond_to?(:pairs)).to eq true
          end
          it 'get filtered rows' do
            pairs = pair_map(Dow1.holiday.pairs)
            expect(Dow1.where(:holiday => true).all? { |dow| pairs[dow.id] == dow.name }).to eq true
          end
        end
      end
      context 'use mastar_name method' do
        it 'use mastar_name attr as name' do
          pairs = pair_map(Dow3.pairs)
          expect(Dow3.all.all? { |dow| pairs[dow.id] == dow.short_name }).to eq true
        end
      end
      context 'use mastar_value method' do
        it 'use mastar_value attr as value' do
          pairs = pair_map(Dow2.pairs)
          expect(Dow2.all.all? { |dow| pairs[dow.short_name] == dow.name }).to eq true
        end
      end
    end
    describe 'define direct class method' do
      context 'no argument' do
        it 'get record object' do
          expect(Dow1.respond_to?(:sunday)).to eq false
          expect(Dow1.sunday.is_a?(Dow1)).to eq true
          expect(Dow1.respond_to?(:sunday)).to eq true
          expect(Dow1.sunday.name).to eq 'sunday'
        end
      end
      context 'with 1 argument' do
        it 'get attribute value at direct' do
          expect(Dow1.monday(:short_name)).to eq 'Mon.'
        end
      end
      context 'with multiple arguments' do
        it 'get Array of attribute values at a time' do
          expect(Dow1.tuesday(:short_name, :holiday).is_a?(Array)).to eq true
          short_name, name = Dow1.wednesday(:short_name, :name)
          expect(short_name).to eq 'Wed.'
          expect(name).to eq 'wednesday'
        end
      end
      context 'mastar.key is not set' do
        it 'raise NoMethodError' do
          expect { Dow2.monday }.to raise_error(NoMethodError)
        end
      end
    end
    describe 'not exist in key column' do
      context 'no argument' do
        it 'get nil' do
          expect(Dow1.foo).to be_nil
        end
      end
      context 'with 1 argument' do
        it 'get nil' do
          expect(Dow1.bar(:name)).to be_nil
        end
      end
      context 'with multiple arguments' do
        it 'get nil' do
          expect(Dow1.baz(:name, :value)).to be_nil
        end
      end
    end
    describe '.mastar multiple setting' do
      context 'mastar#name, mastar#value' do
        it '.pairs method works' do
          pairs = pair_map(Dow4.pairs)
          expect(Dow4.all.all? { |dow| pairs[dow.name] == dow.short_name }).to eq true
        end
      end
      context 'mastar#key' do
        it 'direct class method defining works' do
          expect(Dow4.respond_to?(:sunday)).to eq false
          expect(Dow4.sunday.is_a?(Dow4)).to eq true
          expect(Dow4.respond_to?(:sunday)).to eq true
          expect(Dow4.sunday.name).to eq 'sunday'
        end
      end
    end
    describe '.get' do
      context 'called by cached id' do
        it 'get cached record' do
          rec = Dow4.wednesday
          expect(rec.respond_to?(:iii)).to eq false
          class << rec
            def iii
              'iii'
            end
          end
          expect(Dow4.get(4).respond_to?(:iii)).to eq true
        end
      end
      context 'called by uncached id' do
        it 'get new record and cache' do
          recs = Dow4.__send__(:mastar_records)
          expect(recs[5]).to be_nil
          Dow4.get(5)
          recs = Dow4.__send__(:mastar_records)
          expect(recs[5]).not_to be_nil
        end
      end
    end
  end
  describe "instance methods" do
    context 'record update' do
      it 'direct method record is updated automatically' do
        expect(Dow1.friday.holiday?).to eq false
        fri = Dow1.find(Dow1.friday.id)
        fri.holiday = true
        fri.save
        expect(Dow1.friday.holiday?).to eq true
      end
    end
    context "judge method" do
      context "method name is `code` + ?" do
        it "respond to method name" do
          expect(Dow4.sunday.respond_to?(:monday?)).to eq true
        end
        context "method name equals to code" do
          it "returns true" do
            expect(Dow4.sunday.sunday?).to eq true
          end
        end
        context "method name does not equal to code" do
          it "returns false" do
            expect(Dow4.sunday.monday?).to eq false
          end
        end
      end
      context "method name is `not code` + ?" do
        it "not respond to method name" do
          expect(Dow4.sundy.respond_to?(:foo?)).to eq false
        end
        it "raise error" do
          expect { Dow4.sunday.birthday? }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
