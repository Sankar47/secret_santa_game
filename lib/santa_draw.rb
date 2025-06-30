# frozen_string_literal: true

# lib/santa_draw.rb
class SantaDraw
  def initialize(participants, previous_pairings)
    @participants = participants
    @previous_pairings = previous_pairings
  end

  def draw_matches
    raise 'Not enough participants' if @participants.size < 2

    loop do
      shuffled = @participants.shuffle
      match_map = @participants.zip(shuffled).to_h

      next if invalid_matches?(match_map)

      return match_map
    end
  end

  private

  def invalid_matches?(match_map)
    match_map.any? do |santa, recipient|
      santa == recipient || @previous_pairings[santa] == recipient
    end
  end
end
