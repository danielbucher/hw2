class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings

   if params[:ratings] #Ratings to filter

     @checked_ratings = params[:ratings].keys
     
     if params[:order_option] #Has order_option
       
       @movies = Movie.order_and_filter_by(params[:order_option], @checked_ratings)

     else #Has no order_option
       
       @movies = Movie.order_and_filter_by(@checked_ratings)
       
     end      
     
   else #No ratings
     
     if params[:order_option] #Has order_option
       
       @movies = Movie.order_and_filter_by params[:order_option]

     else #Has no order_option
       
       @movies = Movie.order_and_filter_by
       
     end 
   
   end  #End major conditional

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
