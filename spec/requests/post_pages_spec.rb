require 'spec_helper'

describe "Post Pages" do

  subject { page }

  let(:base_title) { "The blog of Abyanov Bulat" }

  describe "index page" do
    before { visit posts_path }

    it { should have_title("#{base_title} | Blog")}
  end

  describe "show page" do
    let(:post) { FactoryGirl.create(:post) }
    before { visit post_path(post) }

    it { should have_title("#{base_title} | #{post.title}") }
    it { should have_selector('h1', text: post.title) }
    it { should have_content(post.body)  }
  end
end
