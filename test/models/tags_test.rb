require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class TagsTest < Test::Unit::TestCase
  context "Tags Model" do
    should 'construct new instance' do
      @tags = Tags.new
      assert_not_nil @tags
    end
  end
end
