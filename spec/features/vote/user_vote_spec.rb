require "rails_helper"

feature "vote for reviews", %Q{
  As an authenticated user
  I want to vote for a Review to an Actor
  So that others can vote on it
  } do

    # ACCEPTANCE CRITERIA
    # * User must be Authenticated
    # * From the Actor show page
    # * User can vote up a review
    # * Sort reviews by vote count

  scenario "sucessfully up vote a review for an actor" do
    vote = FactoryGirl.create(:vote)
    review = FactoryGirl.create(:review, actor_id: vote.review.actor_id)
    lower_review = FactoryGirl.create(:lower_review, review_id: review.id)

    visit actor_path(vote.review.actor.id)
    click_link 'Agree'

    expect(page).to have_current_path(actor_path(review.actor.id))
  end

  scenario "sucessfully down vote a review for an actor" do
    vote = FactoryGirl.create(:vote)
    review = FactoryGirl.create(:review, actor_id: vote.review.actor_id)
    higher_review = FactoryGirl.create(:higher_review, review_id: review.id)

    visit actor_path(vote.review.actor.id)
    click_link 'Disagree'

    expect(page).to have_current_path(actor_path(review.actor.id))
  end
end
