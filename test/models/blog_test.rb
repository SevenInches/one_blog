require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class BlogTest < Test::Unit::TestCase
  context "Blog Model" do
    should 'construct new instance' do
      @blog = Blog.new
      assert_not_nil @blog
    end
  end
end
