# frozen_string_literal: true

# lib/participant.rb
class Participant
  attr_reader :name, :email

  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def ==(other)
    name == other.name && email == other.email
  end
end
