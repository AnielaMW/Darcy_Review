class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_actor, only: [:new, :create]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :find_actor, only: [:show]
  before_action :collections, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params.merge({user_id: "#{current_user.id}", actor_id: @actor.id}))
    if @review.save
      flash[:notice] = "Your review was created!"
      redirect_to actor_path(@review.actor)
    else
      flash[:alert] = @review.errors.full_messages.join(", ")
      redirect_to new_actor_review_path
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "Your review has been updated!"
      redirect_to review_path(@review)
    else
      flash[:alert] = @review.errors.full_messages.join(", ")
      redirect_to edit_review_path(@review)
    end
  end

  def destroy
    @review.destroy
    redirect_to actor_path(@review.actor)
  end

  private
  def set_actor
    @actor = Actor.find(params[:actor_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def find_actor
    @actor = @review.actor
  end

  def collections
    @rating_collection = Review::RATINGS
  end

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
