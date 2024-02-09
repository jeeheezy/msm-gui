class MoviesController < ApplicationController
  def create
    new_movie = Movie.new

    new_movie.title = params["title"]
    new_movie.year = params["year"]
    new_movie.duration = params["duration"]
    new_movie.description = params["description"]
    new_movie.image = params["image"]
    new_movie.director_id = params["director_id"]

    new_movie.save

    redirect_to("/movies")
    # Retrieve the user's input from params
    # Create a record in the movie table
    # Populate each column with the user's input
    # Save

    # Redirect the user to /movies URL
    
  end

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
