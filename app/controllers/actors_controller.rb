class ActorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @actors = Actor.all
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params.merge({user_id: "#{current_user.id}"}))
    if @actor.save
      flash[:notice] = "Your Darcy was created!"
      redirect_to actors_path
    else
      flash[:alert] = @actor.errors.full_messages.join(", ")
      render new_actor_path
    end
  end

  def edit
  end

  def update
  end

  private
  def actor_params
    params.require(:actor).permit(
      :first_name,
      :last_name,
      :description,
      :movie,
      :book_title,
      :year
    )
  end
end
