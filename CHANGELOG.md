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

This week we generated a model and an associated controller to display books from the database.

The first thing we did was use Rails to generate a model with this command:
`rails generate model Book title:string page_numbers:integer dewey_decimal:float`

This generated a model file.  This is a class like any other in Ruby so you can add book specific methods here.  The only thing we cared about is the fields we created, so nothing was added.  To add a `books` table to the database, we run the auto-generated migration file with this command:
`rails db:migrate`

To explore the database, it's common to use the Rails Console.
`rails console`

Once in the console, we used these commands to explore what data was available.
```
Book.all
book = Book.new
book.title = 'Ruby Class!'
book.attributes = {page_numbers: 1000, dewey_decimal: 100.730}
book.save!
Book.create(title: 'Book 2', page_numbers: 1_000_000, dewey_decimal:1)
Book.count
```

Now that we generated some data for the database, we want a controller for books.  ("g" is short for "generate")
`rails g controller books`

Next we modified our `config/routes.rb` file, to include routes for this new books "resource":
`resources :books`
Creating a resource creates routes for all the basic CRUD operations.  The Rails docs explain it more in depth: https://guides.rubyonrails.org/routing.html#resources-on-the-web

First we wanted to see a list of books in the database.
First we added an `index` method to `app/controllers/books_controller.rb`.

```
def index
  @books = Book.all
end
```

We also created a new view in `app/views/books` called `index.html.erb`.
```
<h1>Books</h1>

<ul>
  <% @books.each do |book| %>
  <li><strong><%= book.title %></strong><br/>Pages: <%= book.page_numbers%></li>
  <% end %>
</ul>
```

Now with the server running, `localhost:3000/books` showed our list of books.

Next we created a `show` action in the `books_controller` and an associated view, `app/views/books/show.html.erb`.

Then we went back and revised these two pages to include links between them with the `link_to` helper.  We had to check the docs to call it successfully, https://apidock.com/rails/ActionView/Helpers/UrlHelper/link_to.

After class, added a link to the welcome page to make it easier to find the index page.