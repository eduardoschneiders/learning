def options
  options = Array.new

  options << "What would you like to do?"
  options << "-- Type 'add' to add a movie."
  options << "-- Type 'update' to update a movie."
  options << "-- Type 'display' to display all movies."
  options << "-- Type 'delete' to delete a movie."
  options << "-- Type 'exit' to exit."

  options.join("\n")
end

def add
  puts 'Movie title: '
  movie_title = gets.chomp
  puts 'Movie rating: '
  movie_rating = gets.chomp

  unless movieExist?(movie_title)
    movie = Hash.new()
    movie[:title] = movie_title
    movie[:rating] = movie_rating

    @movies << movie
  else
    puts 'Movie already exist!'
  end
end

def update
  puts 'Movie title to update: '
  old_movie_title = gets.chomp
  puts 'New movie title. Leave blank to skip: '
  new_movie_title = gets.chomp
  puts 'New rating. Leave blank to skip: '
  new_movie_rating = gets.chomp


  unless movieExist?(old_movie_title)
    puts "Movie didn't found"
    return false
  end

  @movies.each do |movie|
    if movie[:title] == old_movie_title

      unless new_movie_title.empty?
        movie[:title] = new_movie_title
      end

      unless new_movie_rating.empty?
        movie[:rating] = new_movie_rating
      end
    end
  end
end

def display
  @movies.each do |movie|
    puts "Movie title: #{movie[:title]}\n"
    puts "Rating: #{movie[:rating]}\n"
  end
end

def delete
  puts 'Movie title to delete: '
  movie_title = gets.chomp

  unless movieExist?(movie_title)
    puts "Movie didn't found"
    return false
  end

  @movies.delete_if { |movie|  movie[:title] == movie_title }
end

def movieExist?(movie_title)
  @movies.each do |movie|
    if movie[:title] == movie_title
      return true
    end
  end
  return false
end

loop do
  @movies ||= Array.new()

  puts options
  option = gets.chomp

  break if option == 'exit'

  case option
  when 'add'
    add
  when 'update'
    update
  when 'display'
    display
  when 'delete'
    delete
  end
end
