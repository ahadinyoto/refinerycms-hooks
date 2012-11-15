require 'refinery/hooks/processor'
require 'csv'

# Overwrite "render" to enable hook
module Refinery
  module Hooks
    module Renderer
      protected
      def render(*args, &block)
        unless @page.nil?
          @page.parts.each do |page|
            #page.body.gsub! /\{\{([\w\-]+)\}\}/ do |m|
            unless page.body.nil?
              page.body.gsub! /(\{\{([\w\-]+)(\s*\|\s*[\w, \t'"]+)?\}\})/ do |m|
                begin
                  processor = Refinery::Hooks::Processor.new($2)
                  unless $3.nil?
                    @tag_args = CSV.parse($3.strip.gsub(/^\|/, '').strip)[0]
                  end
                  m = processor.run_hook page, @tag_args
                rescue
                  ""
                end
              end
            end
          end
        end
        super(*args, block)
      end
    end
  end
end
