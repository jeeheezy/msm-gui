class ActorsController < ApplicationController
  def create
    new_actor = Actor.new
    new_actor.name = params["name"]
    new_actor.dob = params["dob"]
    new_actor.bio = params["bio"]
    new_actor.image = params["image"]
    new_actor.save
    redirect_to("/actors")
  end

  def destroy
    id = params["path_id"]
    matching_record = Actor.where({ :id => id })
    actor = matching_record[0]
    actor.destroy
    redirect_to("/actors")
  end

  def update
    id = params["path_id"]
    matching_record = Actor.where({ :id => id })
    actor = matching_record[0]
    actor.name = params["name"]
    actor.dob = params["dob"]
    actor.bio = params["bio"]
    actor.image = params["image"]
    actor.save
    redirect_to("/actors/#{id}")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
