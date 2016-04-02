# == Schema Information
#
# Table name: followed_teams
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  team_document_id :string(255)
#  created_at       :datetime         default(2012-03-12 21:01:09 UTC)
#  team_id          :integer
#

class FollowedTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
end
