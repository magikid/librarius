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

## Week 5

During this week, we talked about how requests work and added a form to allow entering new books.  There are two main types of requests that a server should handle: `GET` requests and `POST` requests.  When you visit a webpage, that's normally a `GET` request because you're `GET`ting the page.  When you enter information into a form and send it to the server you're making a `POST` request as though you were sending it through the `POST` Office.  When we added our resource routes for Books the other week, there are two routes that deal with allowing a user to send data to our server.  You can see them by running `bin/rails routes` in your project directory.

```
                   Prefix Verb   URI Pattern                                                                              Controller#Action
                 new_book GET    /books/new(.:format)                                                                     books#new
                          POST   /books(.:format)                                                                         books#create
```

The first route maps a GET request and the URL `/books/new` to our `books_controller` and the `new` action.  The second route maps a POST request and the URL `/books` to the `books_controller` and the `create` action.  To allow users to enter a new book, the user will first visit the new book page where they will be presented with a form for a book and when they submit the form, it will send the form data as a POST request to the `/books` route where our controller will save it to the database.

In our books_controller, we first added the `new` action and set it up to look like this:

```ruby
  def new
    @book = Book.new
  end
```

That tells rails to create a new, empty book and save it to the `@book` variable which will be accessible in our `app/views/books/new.html.erb` view.  In our new books view, we created our form using the form builder that comes with Rails.  It looks like this:

```
<%= form_with model: @book, local: true do |form| %>
    <p>
        <%= form.label :title %>
        <%= form.text_field :title %>
    </p>
    <p>
        <%= form.label :page_numbers %>
        <%= form.text_field :page_numbers %>
    </p>
    <p>
        <%= form.label :dewey_decimal %>
        <%= form.text_field :dewey_decimal %>
    </p>
    <%= form.submit %>
<% end %>
```

In the first line, we are telling rails to help us build a form using the `@book` variable from the controller.  We create fields for each of the attributes in our model and then we create a submit button.  For more reading on the form builder, check out the [Rails Guide on Form Helpers](https://guides.rubyonrails.org/form_helpers.html).  After saving both of those files, if you go to the http://localhost:3000/books/new , you should see the new form that we just created.  If you try to submit it though, you'll get an error because we haven't told the controller how to handle the create request yet.

In the `books_controller` again, we added our next action: the `create` action which looks like this:

```ruby
  def create
    params.require(:book).permit!
    @book = Book.new(params[:book])
    if @book.save
      redirect_to book_path(@book)
    end
  end
```

The first line is required to tell rails that we want to allow the book form data from the request.  Once we have that, we create a new book from the data and then we save it.  If the save was successful, we redirect the user to show them the new book.  Since we are always redirecting the user to a new page, there is _no_ view for this action.

## Week 6

In week 6, we added Bootstrap to our site so that it would be responsive and we talked about how rails takes a view and turns it into the full HTML web page that you see when you visit a page.

First we started by adding the following lines to the bottom of our Gemfile:

```
gem 'bootstrap'
gem 'jquery-rails'
```

After adding them, we ran `bundle install` to install the new dependencies.  To integrate bootstrap into our application, we needed to change two other files `app/assets/javascripts/application.js` and `app/assets/stylesheets/application.css`.  For `application.js`, we added a few lines near the bottom.  Right above the line that says `//= require_tree .`, we added these lines:

```
//= jquery3
//= popper
//= bootstrap
# Below line is already in the file
//= require_tree .
```

That tells Rails to include the bootstrap javascript in our pages.  Up next, we deleted the file `app/assets/stylesheets/application.css` and we created the file `app/assets/stylesheets/application.scss`.  Their names are very similar but the second one ends in `scss` and that is what we need.  We added this single line to the `application.scss` file:

```scss
@import 'bootstrap';
```

That tells Rails to import the bootstrap css into our pages.  With all that in place, we finally modified the file `app/views/layouts/application.html.erb`.  Rails uses this file to turn your views into full webpages.  Where you see the line `<%= yield %>` is where the HTML from your view is inserted.  To use bootstap in our application, we changed the `<body></body>` to look like this:

```html
<body>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
        <%= yield %>
        </div>
      </div>
    </div>
</body>
```

That tells Rails to use wrap all of our pages into a bootstrap container, row, and column.  For more reading on how we integrated Bootstrap into our Rails application, [here is the FreeCodeCamp blog post that I used](https://medium.freecodecamp.org/add-bootstrap-to-your-ruby-on-rails-project-8d76d70d0e3b).  For a refresher on Bootstrap, [here's their documentation](https://getbootstrap.com/docs/4.3/getting-started/introduction/).

After adding bootstrap, we did one final thing for the night.  We added a delete link to our books index view and added a destroy action to our controller.

If you look in the routes we created a few weeks ago with the command `bin/rails routes` you'll see the following line:

```
                   Prefix Verb   URI Pattern                                                                              Controller#Action
                          DELETE /books/:id(.:format)                                                                     books#destroy
```

That maps a `DELETE` request and the `/books/:id` path to the `books_controller` and `destroy` action.  We started by adding the action to our controller.  Here's what we added to our `books_controller.rb`:

```ruby
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end
```

The first line takes the id that is passed in and finds that book.  Then we use the `destroy` method to delete that book from the database.  Once it's deleted, we redirect to the list of books at the `books_path`.  All that is left is to add a link on our books/index view that allows users to delete books from the database.  We changed the inside of the `@books.each` block to the following in our `app/views/books/index.html.erb` file:

```
    <li>
      <strong><%= link_to(book.title, book_path(book)) %></strong> -
      <small><%= link_to('DESTROY!', book_path(book),
          method: :delete,
          data: { confirm: "Are you sure?" }
        ) %></small>
    </li>
```

The big change is adding the DESTROY link.  We pass in "DESTROY!" as the text that the user will see
and point it at the `books_path(book)` route which translates to `/books/:id`.  Then we tell Rails
that instead of making this a normal `GET` request to make this a `DELETE` request using the
`method: :delete`.  The last line gives the user a pop-up confirming that they want to delete the
book they selected.

## Week 7

We finally got the ability to edit our books this week by creating two new actions in the
`BooksController`.  We first created the edit action by adding the following code block:

```ruby
    def edit
        @book = Book.find(params[:id])
    end
```

This tells rails that when a user tries to edit a book, first look up the values of the current book
in the database and pass that to the view.

Next we added another block of code to the `BooksController` to handle the user sending in the updated form:

```ruby
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to @book
        else
            render 'edit'
        end
    end
```

There's a lot going on here so lets dissect it a little bit.  The first line `@book =
Book.find(params[:id])` should look familiar from the edit action.  We're looking up the book that
the user wants to edit.  Then we have an `if/else` block that tells rails to try to update the book
with the new values (`@book.update(book_params)`) and if Rails can update the model then redirect
the user to the updated book's show route.  If it can't save the model, render the 'edit' view which
will then show the users the errors that caused the model to not be saved.

The final piece that you need to add to the BooksController needs to go at the very bottom and it's
this block:

```ruby
  private

  def book_params
    params.require(:book).permit!
  end
```

If you look in our `update` action, you'll see that we are passing `book_params` to the `update`
method. `book_params` is actually a function that gets the data from the form our user submitted.
Take a look at the (Strong Parameters documentation)[https://edgeguides.rubyonrails.org/action_controller_overview.html#strong-parameters] if you want to know more.

Now we need to add the view so that our users can have a form to submit their edits.  We used a
partial view for this.  To do that, we created a new file at `app/views/books/_form.html.erb` and we
added this block to it:

```ruby
    <%= form_with model: @book, local: true do |form| %>
        <% if @book.errors.any? %>
            <h2>
                <%= pluralize(@book.errors.count, "error") %> prohibited this from being saved:
            </h2>
            <ul>
                <% book.errors.full_messages.each do |msg| %>
                    <li><%= msg %></li>
                <% end %>
            </ul>
        <% end %>
        <p>
             <%= form.label :title %>
            <%= form.text_field :title %>
        </p>
        <p>
            <%= form.label :page_numbers %>
            <%= form.text_field :page_numbers %>
        </p>
        <p>
            <%= form.label :dewey_decimal %>
            <%= form.text_field :dewey_decimal %>
        </p>
        <%= form.submit %>
    <% end %>
```

That should look very familiar because it is very similar to our `books/new.html.erb`.  The only
difference is that we have a new block at the top that checks for errors and prints them out if
there are any found.

Now in our `app/views/books/edit.html.erb` file, we tell Rails that we want to use the form partial
with the following:

```ruby
    <h1>Edit Book</h1>
    <%= render 'form' %>
```

Since the form is the same as what we had in our `books/new.html.erb` file, we also updated that
file to look like this:

```ruby
    <h1>New Book</h1>
    <%= render 'form' %>
```

That tells Rails to also render our form partial when it goes to render the new view.

The final change of the week is that we edited our `books/index.html.erb` view and added a link to
edit each of the books:

```ruby
      <small><%= link_to("Edit", edit_book_path(book)) %></small> -
```

That goes right under the `<strong>` tag and right above the other `<small>` tag.

### Wrap up

At this point, our project is feature complete.  This project meets all of the requirements for the
Code Louisville Ruby project.

## Week 9

We created an Author model and associated it with books.  We went on to make an Author Index page to show those relationships.
We added `dependent: :destroy` to the relationship added to the Author model so that all the Author's books would be destroyed when the author is destroyed.

### commands used:
```
rails generate model Author name:string favorit_color:string
rails generate controller authors
rails g migration AddAuthorIdToBooks author:references
rails db:migrate
```
### rails console commands
```
a = Author.create!(name: 'Tom C Author')
Book.create!(title: "Tom's Biography", page_numbers: 5000, dewey_decimal: 100.0, author: a)
a.books.create!(title: 'new book')

Author.all.includes(:books).each do |author|
  author.books.each do |book|
    puts "#{author.name} wrote #{book.title}"
  end
end
```