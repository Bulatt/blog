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

  describe "new page" do
    before { visit new_post_path }
    let(:submit) { "Save post" }

    describe "with invalid information" do
      
      it "should not create a post" do
        expect { click_button submit }.not_to change(Post, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title("#{base_title} | New post") }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title", with: "Example post"
        fill_in "Body",  with: "a" * 140
      end

      it "should create a post" do
        expect { click_button submit }.to change(Post, :count).by(1)
      end

      describe "after saving the post" do

        before { click_button submit }
        let(:post) { Post.find_by(title: 'Example post') }

        it { should have_title("#{base_title} | #{post.title}")}
        it { should have_selector('div.alert.alert-success', text: 'Post created')}
      end
    end
  end

  describe "edit page" do
    let(:post_factory) { FactoryGirl.create(:post) }
    let(:submit) { "Save post" }
    before { visit edit_post_path(post_factory) }

    it { should have_title("#{base_title} | Edit post") }
    it { find_field('Title').value.should eq post_factory.title }
    it { find_field('Body').value.should eq post_factory.body }

    describe "with invalid information" do

       before do
        fill_in "Title", with: " "
        fill_in "Body",  with: "a" 
      end

      describe "after submission" do

        before { click_button submit }

        it { should have_title("#{base_title} | Edit post") }
        it { should have_content('error') }
      end
    end

    describe "with valid information"

      before do
        fill_in "Title", with: "Example post"
        fill_in "Body",  with: "a" * 140
      end

      describe "after saving the post" do

        before { click_button submit }
        let(:post) { Post.find_by(title: 'Example post') }

        it { should have_title("#{base_title} | #{post.title}")}
        it { should have_selector('div.alert.alert-success', text: 'Post successfully saved')}
      end
  end

end
