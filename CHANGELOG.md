# CHANGELOG

## Week 1

In the first week of classes, we got Ruby installed on our laptops.

- Windows users: https://gorails.com/setup/windows/10
- Mac users: https://gorails.com/setup/osx/10.14-mojave
- Ubuntu/Linux users: https://gorails.com/setup/ubuntu/18.10

## Week 2

This week, we got Ruby on Rails installed on everyone's laptops and discussed
what Rails is and how it creates websites.

To install Rails, open up a terminal and run the command `gem install rails`.
To check that Rails was correctly installed, you can run `rails -v` and you
should see the version of Rails that was installed.

## Week 3

We started our class project.  We'll be building a website where users can track
their books.  In the directory where you want to start a new project, run the
command `rails new yourprojectname`.  That will generate a new Rails site.
You'll need to switch into that directory using `cd yourprojectname`.  Once in
that directory, you can run `bin/rails server` to start a server.  You'll see
the following output:

```
=> Booting Puma
=> Rails 5.2.2 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.5.1-p57), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
```

Once you see that, you can visit http://localhost:3000/ where you'll see a
generic page that shows your version of Ruby and your version of Rails.

Now that you have your project generated, we created our first controller and
view.  You can generate a new controller named welcome with a view named index
with the following command:

`bin/rails generate controller welcome index`

That will create several files including your controller in
`app/controllers/welcome_controller.rb` and your view in
`app/views/welcome/index.html.erb`.

If you open your `WelcomeController`, you'll see a single method in there named
index.  That directly maps to the index view in your views folder.  In your
`app/views/welcome/index.html.erb` file, you can put any HTML that you would put
in-between the `<body></body>` tags on an HTML page.

The final thing that needs to be done is to tell Rails how to map an incoming
user request to a particular path to your controller and view.  Modify that
`config/routes.rb` file to have the following two lines:

```ruby
  get 'welcome/index'
  root 'welcome#index'
```

By adding those two lines, you're telling the Rails server that if a user
requests the `/` route, to send them to your welcome controller and index view.
You're also telling Rails that is a user requests the `/welcome/index` route to
also send them to your welcome controller and index view.

## Week 4

rails generate model Book title:string page_numbers:integer dewey_decimal:float

rails db:migrate

rails console

```
Book.all
book = Book.new
book.title = 'Ruby Class!'
book.attributes = {page_numbers: 1000, dewey_decimal: 100.730}
book.save!
Book.create(title: 'Book 2', page_numbers: 1_000_000, dewey_decimal:1)
```

rails g controller books

config/routes.rb
resources :books

new view called index.html.erb
```
<h1>Books</h1>

<ul>
  <% @books.each do |book| %>
  <li><strong><%= book.title %></strong><br/>Pages: <%= book.page_numbers%></li>
  <% end %>
</ul>
```

