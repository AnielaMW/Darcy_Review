require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_valid(:description).when("He's a hottie.", "Not my Darcy") }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:rating).when(1, 5, 10) }
  it { should_not have_valid(:rating).when(nil, "-4", 11, "I like it", "") }

  it { should have_valid(:user_id).when(1, 2) }
  it { should_not have_valid(:user_id).when(nil, '') }

  it { should have_valid(:actor_id).when(1, 2) }
  it { should_not have_valid(:actor_id).when(nil, '') }
end
