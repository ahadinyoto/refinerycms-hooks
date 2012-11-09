namespace :refinery do

  namespace :hooks do

    # call this task by running: rake refinery:hooks:my_task
    desc "Prepare test cases"
    # :environment needed for Rails environment to be loaded
    task :test_prepare => :environment do
      rm_rf "spec/dummy/app/hooks"
      rm "spec/dummy/app/controllers/application_controller.rb"

      # Copy the application_controller loaded with hook renderer
      cp "spec/files/application_controller.rb", "spec/dummy/app/controllers/application_controller.rb"
      cp "spec/files/hooks.rb", "spec/dummy/config/initializers/refinery"

      # Copy the tests hooks
      mkdir "spec/dummy/app/hooks"
      cp "spec/files/test1.rb", "spec/dummy/app/hooks"
      cp "spec/files/test2.rb", "spec/dummy/app/hooks"
      cp "spec/files/test3.rb", "spec/dummy/app/hooks"
      cp_r "spec/files/views", "spec/dummy/app/hooks"
      Refinery::Hooks::Hook.register_hook({:name => "Test1", :tag => "test1"})
      Refinery::Hooks::Hook.register_hook({:name => "Test2", :tag => "test2"})
      Refinery::Hooks::Hook.register_hook({:name => "Test3", :tag => "test3"})
    end

    task :test_destroy => :environment do
      rm_rf "spec/dummy/app/hooks"
      Refinery::Hooks::Hook.deregister_hook("test1")
      Refinery::Hooks::Hook.deregister_hook("test2")
      Refinery::Hooks::Hook.deregister_hook("test3")
    end

  end

end
