class Movie < ActiveRecord::Base
  
  def self.order_by_title
    order("title ASC")
  end
  
  def self.order_by_release_date
    order("release_date ASC")
  end
  
end
