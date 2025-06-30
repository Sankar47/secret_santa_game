# frozen_string_literal: true

# spec/santa_draw_spec.rb
require 'spec_helper'
require_relative '../lib/santa_draw'
require_relative '../lib/participant'

RSpec.describe SantaDraw do
  let(:p1) { Participant.new(name: 'Alice', email: 'alice@example.com') }
  let(:p2) { Participant.new(name: 'Bob', email: 'bob@example.com') }
  let(:p3) { Participant.new(name: 'Carol', email: 'carol@example.com') }
  let(:participants) { [p1, p2, p3] }
  let(:previous_pairings) { { p1 => p2, p2 => p3, p3 => p1 } }

  it 'generates valid Santa pairings' do
    draw = SantaDraw.new(participants, previous_pairings)
    matches = draw.draw_matches

    matches.each do |santa, recipient|
      expect(santa).not_to eq(recipient)
      expect(previous_pairings[santa]).not_to eq(recipient)
    end

    expect(matches.values.uniq.size).to eq(participants.size)
  end
end
