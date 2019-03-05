class AuthorsController < ApplicationController
  def index
    @authors = Author.all.includes(:books).order(:name)
  end
end
