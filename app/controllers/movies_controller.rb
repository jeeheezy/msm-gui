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
  end

  def destroy
    id = params["path_id"]
    matching_record = Movie.where({ :id => id })
    movie = matching_record[0]

    movie.destroy
    redirect_to("/movies")
  end

  def update
    id = params["path_id"]
    matching_record = Movie.where({ :id => id })
    movie = matching_record[0]

    movie.title = params["title"]
    movie.year = params["year"]
    movie.duration = params["duration"]
    movie.description = params["description"]
    movie.image = params["image"]
    movie.director_id = params["director_id"]

    movie.save

    redirect_to("/movies/#{id}")
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
