# == Schema Information
#
# Table name: api_accesses
#
#  id         :integer          not null, primary key
#  api_key    :string(255)
#  awards     :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

RSpec.describe ApiAccess, type: :model do

end
