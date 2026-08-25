class ClassSession < ApplicationRecord
  belongs_to :course

  validates :topic, presence: true
  validates :course_id, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :location_type, presence: true

  with_options if: -> { location_type == "physical" } do
    validates :city, presence: true
    validates :street, presence: true
    validates :building_number, presence: true
    validates :room, presence: true
  end

  with_options if: -> { location_type == "remote" } do
    validates :platform, presence: true
    validates :meeting_url, presence: true, format: {
      with: /\Ahttps?:\/\/.+\z/,
      message: "must be a valid HTTP or HTTPS URL"
    }
  end
end
