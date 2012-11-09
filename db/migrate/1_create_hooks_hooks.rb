class CreateHooksHooks < ActiveRecord::Migration

  def up
    create_table :refinery_hooks do |t|
      t.string :name
      t.string :tag
      t.string :status
      t.text :alt
      t.string :klass
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-hooks"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/hooks/hooks"})
    end

    drop_table :refinery_hooks

  end

end
