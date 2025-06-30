# frozen_string_literal: true

require_relative '../lib/csv_handler'
require_relative '../lib/santa_draw'

begin
  participants = CsvHandler.read_participants('data/participant-list.csv')
  previous_pairings = CsvHandler.load_previous('data/previous-pairings.csv')

  draw = SantaDraw.new(participants, previous_pairings)
  pairings = draw.draw_matches

  CsvHandler.write_pairings(pairings, 'output/santa_pairings.csv')
  puts 'Secret Santa pairings generated successfully!'
rescue StandardError => e
  puts "Error: #{e.message}"
end
