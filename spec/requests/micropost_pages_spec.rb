require 'spec_helper'

describe "Micropost pages" do

    subject { page }

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "micropost creation" do

        before { visit root_path }

        describe "with invalid information" do

            it "should not create a micropost" do
                expect { click_button "Post" }.not_to change(Micropost, :count)
            end # should not create a micropost

            describe "error messages" do
                before { click_button "Post" }
                it { should have_content('error') }
            end # error messages

        end # with invalid information

        describe "with valid information" do
            before { fill_in 'micropost_content', with: "Lorem ipsum" }
            it "should create a micropost" do
                expect { click_button "Post" }.to change(Micropost, :count).by(1)
            end
        end # with valid information

    end # micropost creation
      
   # describe "micropost destruction" do
      #  before { FactoryGirl.create(:micropost, user: user) }

	describe "delete links" do

         let(:user) { FactoryGirl.create(:user) }
         let(:current_user) { FactoryGirl.create(:user) }

         describe "as incorrect user" do
           before { visit root_path }
           it { should_not have_link('delete', href: user_path(user)) }
         end
      end
    
        describe "as correct user" do
            before { visit root_path }
            it "should delete a micropost" do
                expect { click_link "delete" }.to change(Micropost, :count).by(-1)
            end
        end # as correct user

    end # micropost destruction

end # Micropost pages

