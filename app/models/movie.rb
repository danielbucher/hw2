class Movie < ActiveRecord::Base
  
  @@ratings = ['G','PG','PG-13','R','NC-17']
  
  def self.get_ratings
    @@ratings
  end
  
  def self.order_and_filter_by(*args)
    if args[1] #Has both order option and ratings to filter (in that order)
      
      filtered_movies = Movie.where("rating IN (?)", args[1])  
      if args.include?('title')
        
        filtered_and_ordered_movies = []
        
        order("title ASC").each do |m|
          if filtered_movies.include? m
            filtered_and_ordered_movies << m
          end          
        end
        
        filtered_and_ordered_movies
      elsif args.include?('release_date')
        
        filtered_and_ordered_movies = []
        
        order("release_date ASC").each do |m|
          if filtered_movies.include? m
            filtered_and_ordered_movies << m
          end          
        end
        
        filtered_and_ordered_movies
      end     
     
    else #Has one or none param
      
      if (args.empty? || args.include?('title') || args.include?('release_date'))
        []
      #elsif args.include? 'release_date'
      #  order("release_date ASC")
      #elsif args.include? 'title'
      #  order("title ASC")
      else #The param passed must be an Array of ratings
        where("rating IN (?)", args[0])
      end 
          
    end
  end
  
end
