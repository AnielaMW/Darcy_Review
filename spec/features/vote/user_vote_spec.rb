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
    lower_vote = FactoryGirl.create(:lower_vote, review_id: review.id)

    visit actor_path(vote.review.actor.id)
    click_link 'Vote'
    choose 'Agree'

    expect(page).to have_current_path(actor_path(review.actor.id))
    reviews = page.all("div#revlist ul li")
    expect(reviews[0]).to have_content("Ranking: #{vote.review.ranking}")
    expect(reviews[1]).to have_content("Ranking: #{lower_vote.review.ranking}")
  end

  scenario "sucessfully down vote a review for an actor" do
    vote = FactoryGirl.create(:vote)
    review = FactoryGirl.create(:review, actor_id: vote.review.actor_id)
    higher_vote = FactoryGirl.create(:higher_vote, review_id: review.id)

    visit actor_path(vote.review.actor.id)
    click_link 'Disagree'

    reviews = page.all("div#revlist ul li")
    expect(reviews[0]).to have_content("Ranking: #{higher_vote.review.ranking}")
    expect(reviews[1]).to have_content("Ranking: #{vote.review.ranking}")
  end

  scenario "sucessfully change the vote of a review" do
    vote = FactoryGirl.create(:vote)
    vote1 = FactoryGirl.create(:vote, review_id: vote.review_id)
    vote2 = FactoryGirl.create(:vote, review_id: vote.review_id)
    vote3 = FactoryGirl.create(:vote, review_id: vote.review_id)

    visit actor_path(vote.review.actor.id)

    main_review = page.all("div#revlist ul li")
    expect(main_review).to have_content("Ranking: 4")

    click_link 'Disagree'

    main_review = page.all("div#revlist ul li")
    expect(main_review).to have_content("Ranking: 3")
  end
end
