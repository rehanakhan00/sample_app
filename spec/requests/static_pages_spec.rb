require 'spec_helper'

#-------------------------------------------------------------------------------------------

describe "Static pages" do

    subject { page }

    #---------------------------------------------------------------------------------------

    shared_examples_for "all static pages" do
        it { should have_selector("h1", :content => heading) }
        it { should have_selector("title", :content => full_title(page_title)) }
    end

    #---------------------------------------------------------------------------------------

    describe "Home page" do

        before { visit root_path }
        let(:heading) { 'Sample App' }
        let(:page_title) { '' }

        it_should_behave_like "all static pages"
        it { should_not have_selector 'title', text: '| Home' }
     
        #-----------------------------------------------------------------------------------

        describe "for signed-in users" do

            let(:user) { FactoryGirl.create(:user) }

            before do
                FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
                FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
                sign_in user
                visit root_path         
            end # before

            it "should render the user's feed" do
                user.feed.each do |item|
                    page.should have_selector("li##{item.id}", text: item.content)
                end # user.feed.each
            end # should render the user's feed

            describe "follower/following counts" do
                let(:other_user) { FactoryGirl.create(:user) }
                before do
                    other_user.follow!(user)
                    visit root_path
                end
                it { should have_link("0 following", href: following_user_path(user)) }
                it { should have_link("1 followers", href: followers_user_path(user)) }
            end # follower/following counts

        end # for signed-in users

        #-----------------------------------------------------------------------------------
    
    end # Home page

    #---------------------------------------------------------------------------------------

    describe "Help page" do
        before { visit root_path }
        let(:heading) { "Help" }
        let(:page_title) { "Help" }
        it_should_behave_like "all static pages"
    end # Help page

    #---------------------------------------------------------------------------------------

    describe "About page" do
        before { visit root_path }
        let(:heading) { "About" }
        let(:page_title) { "About Us" }
        it_should_behave_like "all static pages"
    end # About page

    #---------------------------------------------------------------------------------------

    describe "Contact page" do
        before { visit root_path }
        let(:heading) { "Contact" }
        let(:page_title) { "Contact" }
        it_should_behave_like "all static pages"
    end # Contact page

    #---------------------------------------------------------------------------------------

end # Static pages

#-------------------------------------------------------------------------------------------

