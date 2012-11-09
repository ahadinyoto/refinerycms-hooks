# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Hooks" do
    describe "Admin" do
      describe "hooks" do
        login_refinery_user

        describe "hooks list" do
          it "should show all the hooks" do
            visit refinery.hooks_admin_hooks_path
            page.should have_content("Test1")
            page.should have_content("Test2")
            page.should have_content("Test3")
          end
        end

        describe "hooks usage" do
          it "should have the tag given by Test1 - direct using render_hook" do
            visit refinery.new_admin_page_path
            fill_in "Title", :with => "Test1"
            fill_in "page_parts_attributes_0_body", :with => "{{test1}}"
            click_button "Save"
            visit '/test1'
            page.should have_content("Replaced-Test1Hook")
          end

          it "should have the tag given by Test2 - using render view" do
            visit refinery.new_admin_page_path
            fill_in "Title", :with => "Test2"
            fill_in "page_parts_attributes_0_body", :with => "{{test2}}"
            click_button "Save"
            visit '/test2'
            page.should have_content("Replaced-Test2Hook")
          end

          it "disabled, should not have test2 hook content as it is disabled" do
            visit refinery.new_admin_page_path
            fill_in "Title", :with => "Test2"
            fill_in "page_parts_attributes_0_body", :with => "{{test2}}"
            click_button "Save"

            hook = Refinery::Hooks::Hook.find_by_tag("test2")
            hook.status = "disabled"
            hook.save!

            visit '/test2'
            save_and_open_page
            page.should_not have_content("Replaced-Test2Hook")
            hook.status = "enabled"
            hook.save!
          end

          it "disabled, should not have test3 hook content as it is disabled" do
            visit refinery.new_admin_page_path
            fill_in "Title", :with => "Test3"
            fill_in "page_parts_attributes_0_body", :with => "sample text"
            fill_in "page_parts_attributes_1_body", :with => "{{test3|one,two}}"
            click_button "Save"

            visit '/test3'
            save_and_open_page
            page.should have_content("one|two")
          end

        end

      end
    end
  end
end
