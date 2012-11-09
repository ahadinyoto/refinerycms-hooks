
FactoryGirl.define do
  factory :hook, :class => Refinery::Hooks::Hook do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

