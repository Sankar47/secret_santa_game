# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/santa_draw'
require_relative '../lib/participant'

RSpec.describe SantaDraw do
  let(:p1) { Participant.new(name: 'Alice', email: 'alice@example.com') }
  let(:p2) { Participant.new(name: 'Bob', email: 'bob@example.com') }
  let(:p3) { Participant.new(name: 'Carol', email: 'carol@example.com') }
  let(:participants) { [p1, p2, p3] }

  describe '#draw_matches' do
    context 'when participants are less than 2' do
      it 'raises an error' do
        expect do
          SantaDraw.new([p1], {}).draw_matches
        end.to raise_error('Not enough participants')
      end
    end

    context 'with valid participants and no prior pairings' do
      it 'returns valid pairings with no self-assignment' do
        draw = SantaDraw.new(participants, {})
        pairings = draw.draw_matches

        expect(pairings.size).to eq(participants.size)

        pairings.each do |santa, recipient|
          expect(santa).not_to eq(recipient)
        end

        expect(pairings.values.uniq.size).to eq(participants.size)
      end
    end

    context 'with prior year pairings' do
      let(:previous_pairings) do
        {
          p1 => p2,
          p2 => p3,
          p3 => p1
        }
      end

      it 'does not repeat previous pairings' do
        draw = SantaDraw.new(participants, previous_pairings)
        pairings = draw.draw_matches

        pairings.each do |santa, recipient|
          expect(santa).not_to eq(recipient)
          expect(previous_pairings[santa]).not_to eq(recipient)
        end

        expect(pairings.values.uniq.size).to eq(participants.size)
      end
    end
  end
end
