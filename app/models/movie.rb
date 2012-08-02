class Movie < ActiveRecord::Base
  
  @@ratings = ['G','PG','PG-13','R','NC-17']
  
  def self.get_ratings
    @@ratings
  end
  
  def self.order_by_title
    order("title ASC")
  end
  
  def self.order_by_release_date
    order("release_date ASC")
  end
  
end
