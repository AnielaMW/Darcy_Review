require 'rails_helper'

RSpec.describe Actor, type: :model do
  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Jones', 'Smith') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:description).when('title', 'something', nil) }

  it { should have_valid(:movie).when('title', 'something', nil) }

  it { should have_valid(:year).when(1813, 1956, 2002) }
  it { should_not have_valid(:year).when(1745, 34, 0, 202) }

  it { should have_valid(:book_title).when('title', 'something', nil) }

  it { should have_valid(:user_id).when(1, 2) }
  it { should_not have_valid(:user_id).when(nil, '') }
end
