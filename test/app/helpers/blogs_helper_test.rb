require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class OneBlog::App::BlogHelperTest < Test::Unit::TestCase
  context "OneBlog::App::BlogsHelper" do
    setup do
      @helpers = Class.new
      @helpers.extend OneBlog::App::BlogsHelper
    end

    should "return nil" do
      assert_equal nil, @helpers.foo
    end
  end
end
