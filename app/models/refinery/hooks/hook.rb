module Refinery
  module Hooks
    class Hook < Refinery::Core::BaseModel
      self.table_name = 'refinery_hooks'

      attr_accessible :name, :tag, :status, :alt, :position

      acts_as_indexed :fields => [:name, :tag, :status, :alt]

      validates :name, :presence => true, :uniqueness => true
      validates_uniqueness_of :tag

      # Returns the namespaced classname of the hook
      def get_class_string
        c = self.tag.titlecase.gsub /\s+/, ""
        "Refinery::Hooks::#{c}Hook"
      end

      # List of status
      def self.status_list
        [ { :status => 'enabled', :label => 'Enabled' },
          { :status => 'disabled', :label => 'Disabled' },
          { :status => 'disabled-with-alt', :label => 'Disabled with alternate message' }
        ]
      end

      # convert status value to array
      def self.status_list_to_a
        status_list.map { |status| status.values[0] }.flatten.map { |status| status.to_s }
      end

      def disabled?
        self.status == "disabled"
      end

      def disabled_with_alt?
        self.status == "disabled-with-alt"
      end

      def find_in_all_pages
        results = []
        pages = Refinery::Page.all
        pages.each do |page|
          page.parts.each do |part|
            #puts "==> #{part.body}"
            unless part.body.scan(/\{\{#{self.tag}\s*(\|?|\}\})/).blank?
              results << page
            end
          end
        end
        results.uniq
      end

      def self.register_hook(data)
        @hook = Refinery::Hooks::Hook.find_by_tag(data[:tag])
        if @hook.nil?
          @hook = Refinery::Hooks::Hook.new()
          @hook.tag = data[:tag]
          @hook.name = data[:name]
          @hook.status = Hook.status_list_to_a.include?(data[:status]) ? data[:status] : "enabled"
          @hook.save!
        end
        @hook
      end

      # Deregister by tag name
      def self.deregister_hook(tag)
        @hook = Refinery::Hooks::Hook.find_by_tag(tag)
        @hook.destroy unless @hook.nil?
      end
    end
  end
end
