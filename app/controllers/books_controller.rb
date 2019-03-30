class BooksController < ApplicationController
  #In order to avoid duplication, this will call the set_book method, before running actions: edit, update, show, and destroy
  before_action :set_book, only: [:edit, :update, :show, :destroy]

  #will be called for the listing of all books in /books/
  def index
    @books = Book.all #we used books plural to help us know we are grabbing ALL articles into this instance variable
  end


  # New Record Action Flow (detail version)
  # (typed route path in browser) /book/new
  # -> BooksController
  #   -> :new action/mehod (new instance of Book Model) & passes on variables automatically
  #     -> Render new.html.erb (display errors second-time around if any & form) & passes on params
  #       -> (submit pressed) CREATE action (new instance of Model Book), no View render
  #         -> (if validation Model passes with book_params i.e Book.save works) SHOW action, /book/[:id]
  #     <- (if validation not passed) goes back to new.html.erb, with errors.

  # Edit Record Action Flow (simple version)
  # (typed path in browser) > (Update Button pressed) EDIT action > (redirect path) UPDATE action > SHOW action

  def new
    @book = Book.new
    #the submit button in new.html.erb, will automatically take me to the action:create and params are passed on
  end

  def create
    #its possible to do a quick manual render, before the action is finished and renders the .html.erb
    #render plain: params[:book].inspect
    #returns: <ActionController::Parameters {"title"=>"ole", "description"=>"mi casa"} permitted: false>

    @book = Book.new(book_params)
    if @book.save
      #it only comes here if it passes the validations in the model for save.
      flash[:notice] = "The Book was Successfuly created"
      #now we can redirect it to the show route path, i.e book_path, so we can show it.
      redirect_to book_path(@book) #it also works with render 'show'
    else
      render 'new' #(or render :new) will render the new.html.rb template again.
    end
  end



  def edit
    #we receive id from the params when we go to the link /books/10/edit, and then
    #the instance variable @book is also passed onto the VIEW template, so the validation error code in edit.html.erb also works.
    #because we are using a rails form, in the template VIEW file, rails will also automatically load up the edit inputs with the current values, based on this id.
  end

  def update
    if @book.update(book_params)   #if i don't do the validation/book_params it will show an error message with parameters missing.
      flash[:notice] = "The Book was Successfuly edited"
      redirect_to book_path(@book) #we are also sending it to the SHOW action to display the changes.
    else
      render 'edit' #(or render :edit) will render the edit.html.rb template again.
    end
  end

  #book_path
  def show
    #we want to show a specific record, and the id is what is returned here, from the call in create action in book_path
  end

  def destroy
    @book.destroy
    flash[:notice] = "The Book was sucessfully deleted"
    redirect_to books_path
  end


  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    #this is need passed on, for the the new and save actions,

    # The params in a controller looks like a Hash, but it's actually an instance of ActionController::Parameters, which provides several methods such as require and permit.
    # The require method ensures that a specific parameter is present, and if it's not provided, the require method throws an error. It returns an instance of ActionController::Parameters for the key passed into require.
    # The permit method returns a copy of the parameters object, returning only the permitted keys and values. When creating a new ActiveRecord model, only the permitted attributes are passed into the model.

    params.require(:book).permit(:title, :description)


    # To be more precise, when you create for eg. doing .new(...), there must be :person hash indicated by require and the person hash will only accept :name and :age indicated by permit.
    #
    # Example:
    #
    # .new(person: { name: "Bhojendra", age: 32 }) // okay
    # .new(person: { name: "Rauniyar" }) // okay
    # .new(person: { name: "Bhojendra", other: 'asdf' }) // not okay
    # .new(person: { full_name: "Bhojendra Rauniyar" }) // not okay
    # .new(detail: { name: "Bhojendra", age: 32 }) // not okay, must be person
  end

end
