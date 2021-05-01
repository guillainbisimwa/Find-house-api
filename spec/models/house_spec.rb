require 'rails_helper'

RSpec.describe House, type: :model do
  it { should validate_presence_of(:picture) }
  it { should validate_presence_of(:about) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:owner) }
end
