class Face < ActiveRecord::Base
  has_many :measures
  has_many :cords, through: :measures

  def avg(point1, point2)
    cords_scope = cords.where(p1: [point2, point1], p2: [point2, point1]).to_a.map(&:length)
    cords_scope.reduce(:+) / cords_scope.size.to_f
  end

  def self.distance(p1, p2)
    Math.sqrt((p1.first.to_f - p2.first.to_f).abs2 + (p1.last.to_f - p2.last.to_f).abs2)
  end
end
