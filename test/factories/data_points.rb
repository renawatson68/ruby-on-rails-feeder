# == Schema Information
#
# Table name: data_points
#
#  id         :integer          not null, primary key
#  series_id  :integer
#  details    :json             not null
#  created_at :datetime         not null
#
# Indexes
#
#  index_data_points_on_series_id  (series_id)
#

FactoryBot.define do
  factory :data_point, class: DataPoint do
    series_id { 0 }
    details { {} }
    created_at { Time.new.utc }
  end
end
