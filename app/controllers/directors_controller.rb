class DirectorsController < ApplicationController
  def create
    new_director = Director.new
    new_director.name = params["name"]
    new_director.dob = params["dob"]
    new_director.bio = params["bio"]
    new_director.image = params["image"]
    new_director.save

    redirect_to("/directors")
  end

  def destroy
    id = params["path_id"]
    matching_record = Director.where({ :id => id })
    director = matching_record[0]
    director.destroy
    
    redirect_to("/directors")
  end

  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
