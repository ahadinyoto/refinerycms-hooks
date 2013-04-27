Hooks extension for Refinery CMS
================================

A "Refinery CMS":http://refinerycms.com/ extension to make *Page* a bit more dynamic.

In Refinery CMS, a **Page** is where you put your content. The Page, however, is static. Occasionally, having dynamic behavior in the content is needed. For instance, if I were to use the Page to display a product with a price. It'd be nice if I can display the price dynamically based on the latest update in my back-end database.

The "hook" will do just that. It allows you to put a simple markup with a tag - {{tag}} - in a **Page** "Body" and "Side Body", and based on the code that you write in the hook, the markup will be rendered accordingly.

Therefore, in my *Page* "Body, I can put something like:

<pre>
Product "A", price: {{price|productA}}
</pre>

The "price" hook code will be called, and its result will be printed. How to write hook is documented below. It's really easy.

This hook is simply to add a bit of intelligent and makes it more dynamic to an otherwise static *Page* content.

Installation
------------

In your Refinery CMS application Gemfile, add:

<pre>
gem 'refinerycms-hooks', :git => 'git://github.com/ahadinyoto/refinerycms-hooks.git'
</pre>

Then run

<pre>
bundle install
rails g refinery:hooks
bundle exec rake db:migrate
</pre>

Writing your hook
-----------------

In your Refinery CMS application root directory, run generator to create the hook.

<pre>
rails generate refinery:hooks:scaffold Test1Hook test1
</pre>

Two files will be created:

<pre>
app/hooks/test1.rb
app/hooks/views/test1.html.erb
</pre>

The _app/hooks/test1.rb_ is to write the logic - I call this _Hook Controller_, and the other is to write the views similar to Rails' Views.

Any instance variables defined in _Hook Controller_ will be automatically available in the view (in this case: _test1.html.erb_). Again, just like Rails' Views.

If you'd rather not using the view but render a text directly from _Hook Controller_, you can use:

```ruby
def hook(args)
  # ... your codes
  render_hook("<b>Hello</b>")
end
```

Passing arguments
-----------------

You can pass arguments to your hook for greater flexibility:

In your *Page* Body, say, you add ("one,two" after "|" are arguments):

<pre>
{{test1|one,two}}
</pre>

Then in your _Hook Controller_, you can simply access those arguments with:

```ruby
def hook(args)
  # args = ["one", "two"]
  render_hook("#{args[0]} and #{args[1]}")
end
```

Changing the hooks path
-----------------------

By default, the hooks are generated in the application's _app/hooks_. You can change them at _config/initializers/refinery/hooks.rb_.

Disabling the hook
------------------

You can go to Refinery CMS Admin page to disable a hook (or even put an alternate message for the disabled hook).

If you really need to totally remove the hook, you can run:

<pre>
rails destroy refinery:hooks:scaffold Test1Hook test1
</pre>

Removing the files alone is not sufficient as the hook will still be registered with Refinery CMS.
