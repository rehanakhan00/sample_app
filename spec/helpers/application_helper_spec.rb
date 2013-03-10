
require 'spec_helper'

describe ApplicationHelper do

    describe "full_title" do

        it "should include the page title" do
        full_title("foo").should =~ /foo/
        end

        it "should include the base title" do
        full_title("foo").should =~ /^Ruby on Rails Tutorial Sample App/
        end

        it "should not include a bar for the home page" do
        full_title("").should_not =~ /\|/
        end

    end

    it "should have the right links on the layout" do

        visit root_path

        click_link "About"
        page.should have_selector 'title', :content => full_title('About Us')

        click_link "Help"
        page.should have_selector 'title', :content => full_title('Help')

        click_link "Contact"
        page.should have_selector 'title', :content => full_title('Contact')

        click_link "Home"

        click_link "Sign up now!"
        page.should have_selector 'title', :content => full_title('Sign up')

        click_link "sample app"
        page.should have_selector 'title', :content => full_title('Sample app')

    end

end

