class FacesController < ApplicationController
  PAIRS = [[27,32], [44,50], [33,62], [22,18], [35, 39], [47, 53], [23, 28], [5, 9], [2, 12], [53, 7] ]

  def create
    face = Face.find_or_create_by(name: face_params[:name])
    measure = face.measures.create

    return render json: {}, status: :forbidden unless measure.id?

    PAIRS.each do |pair|
      measure.cords.create(p1: pair.first, p2: pair.last, length: Face.distance(face_params[:cords][pair.first.to_s], face_params[:cords][pair.last.to_s]))
    end
    render json: {}, status: :ok
  end

  def verify
    unverified_face = face_params[:cords]
    face_scores = Face.all.map do |face|
      score = 0
      PAIRS.each do |pair|
        p1 = [unverified_face["#{pair.first}"].first, unverified_face["#{pair.first}"].last]
        p2 = [unverified_face["#{pair.last}"].first, unverified_face["#{pair.last}"].last]
        score += (Face.distance(p1, p2) - face.avg(pair.first, pair.last)).abs
      end
      [score, face]
    end
    min_score = face_scores.min_by(&:first)
    render json: { name: min_score.last.name }, status: :ok
  end

  private

  def face_params
    params[:face]
  end
end
