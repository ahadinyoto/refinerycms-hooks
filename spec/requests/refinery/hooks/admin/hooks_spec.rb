# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Hooks" do
    describe "Admin" do
      describe "hooks" do
        login_refinery_user

        describe "hooks list" do
          before do
            FactoryGirl.create(:hook, :name => "UniqueTitleOne")
            FactoryGirl.create(:hook, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.hooks_admin_hooks_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.hooks_admin_hooks_path

            save_and_open_page
            click_link "Add New Hook"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Hooks::Hook.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Hooks::Hook.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:hook, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.hooks_admin_hooks_path

              click_link "Add New Hook"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Hooks::Hook.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:hook, :name => "A name") }

          it "should succeed" do
            visit refinery.hooks_admin_hooks_path

            within ".actions" do
              click_link "Edit this hook"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:hook, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.hooks_admin_hooks_path

            click_link "Remove this hook forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Hooks::Hook.count.should == 0
          end
        end

      end
    end
  end
end
