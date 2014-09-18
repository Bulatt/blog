require 'spec_helper'

describe "StaticPages" do

  subject { page }

  let(:base_title) { "The blog of Abyanov Bulat" }

  describe "Home page" do

    before { visit root_path }

    it { should have_content('Skills') }
    it { should have_title("#{base_title}") }
    it { should_not have_title('| Home') }      
  end

  describe "Projects page" do

    before { visit projects_path }
    
    it { should have_selector('h1', text: 'Projects') }
    it { should have_title("#{base_title} | Projects") }
  end

  describe "Contact page" do

    before { visit contact_path }

    it { should have_content('e-mail') }
    it { should have_title("#{base_title} | Contact")}
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Projects"
    expect(page).to have_title("#{base_title} | Projects")
    click_link "Contact"
    expect(page).to have_title("#{base_title} | Contact")
    click_link "Home"
    expect(page).to have_title("#{base_title}")
    click_link "Abyanov Bulat"
    expect(page).to have_title("#{base_title}")
  end

end
