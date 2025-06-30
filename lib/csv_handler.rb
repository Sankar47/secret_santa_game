# frozen_string_literal: true

require 'csv'
require_relative 'participant'
require 'fileutils'

# lib/csv_handler.rb
class CsvHandler
  HEADERS = %w[Santa_Name Santa_EmailID Recipient_Name Recipient_EmailID].freeze

  class << self
    def read_participants(file_path)
      ensure_file_exists!(file_path)

      parse_csv(file_path).map do |row|
        build_participant(row['Employee_Name'], row['Employee_EmailID'])
      end
    rescue CSV::MalformedCSVError => e
      raise "Error reading participants CSV: #{e.message}"
    end

    def load_previous(file_path)
      ensure_file_exists!(file_path)

      build_pairings(file_path)
    rescue CSV::MalformedCSVError => e
      raise "Error reading previous pairings CSV: #{e.message}"
    end

    def write_pairings(pairings, file_path)
      dir = File.dirname(file_path)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)

      CSV.open(file_path, 'w') do |csv|
        csv << HEADERS
        pairings.each do |santa, recipient|
          csv << [santa.name, santa.email, recipient.name, recipient.email]
        end
      end
    rescue IOError => e
      raise "Failed to write to output CSV: #{e.message}"
    end

    private

    def ensure_file_exists!(file_path)
      raise "File not found: #{file_path}" unless File.exist?(file_path)
    end

    def parse_csv(file_path)
      CSV.read(file_path, headers: true, encoding: 'bom|utf-8')
    end

    def build_participant(name, email)
      Participant.new(name: name, email: email)
    end

    def validate_row!(row, santa, recipient)
      return unless [santa.name, santa.email, recipient.name, recipient.email].any?(&:nil?)

      raise "Missing fields in pairing row: #{row.inspect}"
    end

    def build_pairings(file_path)
      parse_csv(file_path).each_with_object({}) do |row, pairings|
        santa = build_participant(row['Employee_Name'], row['Employee_EmailID'])
        recipient = build_participant(row['Secret_Child_Name'], row['Secret_Child_EmailID'])
        validate_row!(row, santa, recipient)
        pairings[santa] = recipient
      end
    end
  end
end
