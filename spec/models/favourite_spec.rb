require 'rails_helper'

RSpec.describe Favourite, type: :model do
  # Association test
  # ensure an item record belongs to a single user record
  it { should belong_to(:user) }
end
