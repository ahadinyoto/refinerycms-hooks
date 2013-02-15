Refinery::Hooks.configure do |config|
  config.hook_path = Rails.root.join("app", "hooks")
  config.hook_view_path = Rails.root.join("app", "hooks", "views") 
end
