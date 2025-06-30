# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/csv_handler'

RSpec.describe CsvHandler do
  let(:missing_file_path) { 'nonexistent.csv' }
  let(:malformed_csv_path) { 'spec/fixtures/malformed.csv' }
  let(:incomplete_csv_path) { 'spec/fixtures/incomplete.csv' }
  let(:valid_csv_path) { 'spec/fixtures/valid.csv' }

  describe '.read_participants' do
    it 'raises error when file does not exist' do
      expect do
        CsvHandler.read_participants(missing_file_path)
      end.to raise_error(/File not found/)
    end

    it 'raises error for malformed CSV' do
      expect do
        CsvHandler.read_participants(malformed_csv_path)
      end.to raise_error(/Error reading participants CSV/)
    end
  end

  describe '.load_previous' do
    it 'raises error when file does not exist' do
      expect do
        CsvHandler.load_previous(missing_file_path)
      end.to raise_error(/File not found/)
    end

    it 'raises error for malformed CSV' do
      expect do
        CsvHandler.load_previous(malformed_csv_path)
      end.to raise_error(/Error reading previous pairings CSV/)
    end

    it 'raises error when required fields are missing' do
      expect do
        CsvHandler.load_previous(incomplete_csv_path)
      end.to raise_error(/Missing fields in pairing row/)
    end
  end
end
