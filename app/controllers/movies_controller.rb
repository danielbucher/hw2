class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
      @all_ratings = Movie.get_ratings

      if params[:commit] == 'Refresh' #Check if there was a form submition
          if params[:ratings] #New ratings to filter    
              session[:ratings] = params[:ratings]         
          elsif session[:ratings] #No rates checked       
              session.delete(:ratings)       
          end 
          
          flash.keep
          redirect_to movies_path(:ratings => session[:ratings], :order_option => session[:order_option])
      elsif session[:ratings]       
          @checked_ratings = session[:ratings].keys
     
          if params[:order_option] #Has order_option
              session[:order_option] = params[:order_option]       
              @movies = Movie.order_and_filter_by(session[:order_option], @checked_ratings)
          elsif session[:order_option] #Has no order_option     
              @movies = Movie.order_and_filter_by(session[:order_option], @checked_ratings)     
          else         
              @movies = Movie.order_and_filter_by(@checked_ratings)       
          end
          
          unless params[:ratings]
              flash.keep
              redirect_to movies_path(:ratings => session[:ratings], :order_option => session[:order_option]) 
          end               
      else #No ratings     
          if params[:order_option] #Has order_option
              session[:order_option] = params[:order_option]        
              @movies = Movie.order_and_filter_by session[:order_option]
          elsif session[:order_option] #Has no order_option on params list            
              flash.keep
              redirect_to movies_path(:ratings => session[:ratings], :order_option => session[:order_option])      
          else       
              @movies = Movie.order_and_filter_by       
          end   
      end  #End major conditional

  end #End action

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
