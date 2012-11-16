# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Hooks" do
    describe "Admin" do
      describe "hooks" do
        login_refinery_user

        it "should not have 'Add New Hook'" do
          page.should_not have_content("Add New Hook")
        end
      end
    end
  end
end
