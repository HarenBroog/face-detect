class Measure < ActiveRecord::Base
  belongs_to :face
  has_many   :cords

  validate :max_measure

  def max_measure
    errors.add(:id, "too much") if face.measures.length >= 5
  end
end
