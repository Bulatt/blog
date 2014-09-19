require 'spec_helper'

describe Post do
 
  before do
    @post = Post.new(title: "Example Post", body: "a" * 130 )
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:body) }

  it { should be_valid }

  describe "when title is not present" do
    before { @post.title = " "}
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { @post.body = " "}
    it { should_not be_valid }
  end

  describe "when title is short" do
    before { @post.title = "a" * 9 }
    it { should_not be_valid }
  end

  describe "when  title is too long" do
    before { @post.title = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when body is short" do
    before { @post.body = "a" * 129 }
    it { should_not be_valid }
  end

  describe "when  title is repeated" do
    before do
      post_with_same_title = @post.dup
      post_with_same_title.save
    end

    it { should_not be_valid }
  end


end
