require 'spec_helper'

describe Hash do
  context '#symbolize_nested_keys!' do
    context 'for hashes with string keys' do
      before do
        @h = { "foo" => "bar", "baz" => 1 }
        @h.symbolize_nested_keys!
      end
      it 'symbolizes keys' do
        @h[:foo].should eq("bar")
      end
      it 'deletes keys' do
        @h["foo"].should be_nil
      end
    end

    context "for hashes with keys which are symbols" do
      it 'leaves well enough alone' do
        h = { :rosebud => "sled" }
        h.symbolize_nested_keys!
        h[:rosebud].should eq("sled")
      end
    end

    context 'for nested hashes with string keys' do
      before do
        @h = { "movie" => { "title" => "Citizen Kane", "sled" => "rosebud" } }
        @h.symbolize_nested_keys!
      end

      it 'symbolizes keys' do
        @h[:movie][:title].should eq("Citizen Kane")
      end
    end

    context 'for string keys of hashes nested within arrays' do
      it 'symbolizes keys' do
        h = { "list" => "Movie list",
              "movies" => [
                { "title" => "Citizen Kane" },
                { "title" => "Badlands" }
              ] }
        h.symbolize_nested_keys!
        h[:movies].last[:title].should eq("Badlands")
      end
    end
  end
end
