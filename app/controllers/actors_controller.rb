class ActorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_actor, only: [:show, :edit, :update, :destroy]

  def index
    @actors = Actor.all
  end

  def show
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
    if @actor.update(actor_params)
      flash[:notice] = "Your Darcy has been updated!"
      redirect_to actor_path(@actor)
    else
      flash[:alert] = @actor.errors.full_messages.join(", ")
      redirect_to edit_actor_path(@actor)
    end
  end

  def destroy
    if @actor.reviews
      @actor.reviews.destroy
    end
    @actor.destroy
    redirect_to root_path
  end

  private
  def set_actor
    @actor = Actor.find(params[:id])
  end

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
