class VotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_review, only: [:new, :create]
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_action :collections, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params.merge({user_id: "#{current_user.id}", review_id: @review.id}))
    if @vote.save
      flash[:notice] = "Your vote has been counted!"
      redirect_to review_path(@vote.review)
    else
      flash[:alert] = @vote.errors.full_messages.join(", ")
      redirect_to new_review_vote_path
    end
  end

  def edit
  end

  def update
    if @vote.update(vote_params)
      flash[:notice] = "Your vote has been updated!"
      redirect_to vote_path(@vote)
    else
      flash[:alert] = @vote.errors.full_messages.join(", ")
      redirect_to edit_vote_path(@vote)
    end
  end

  def destroy
    @vote.destroy
    redirect_to review_path(@vote.review)
  end

  private
  def set_review
    @review = review.find(params[:review_id])
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def find_review
    @review = @vote.review
  end

  def collections
    @rating_collection = Vote::RATING
  end

  def vote_params
    params.require(:vote).permit(
      :description,
      :rating
    )
  end

end
