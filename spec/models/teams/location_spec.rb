# == Schema Information
#
# Table name: teams_locations
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  address            :text
#  city               :string(255)
#  state_code         :string(255)
#  country            :string(255)
#  team_id            :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  points_of_interest :string(255)      default([]), is an Array
#

require 'rails_helper'

RSpec.describe Teams::Location, type: :model do
  it { is_expected.to belong_to(:team) }
end
