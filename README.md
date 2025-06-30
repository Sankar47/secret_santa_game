# Secret Santa Game

## 📖 Overview
This Ruby-based Secret Santa game automates the pairing of participants such that:
- Each person is randomly assigned a gift recipient.
- No one is paired with themselves.
- No one is paired with the same person they had last year.
- Every participant has a unique recipient.

## Setup & Usage

### 1. Install Dependencies
```bash
git clone https://github.com/Sankar47/secret_santa_game.git
cd secret_santa_game
bundle install
```

---

### 2. Run the Game
```bash
ruby bin/secret_santa.rb
```
> Outputs to: `output/santa_pairings.csv`

---

## 3. Running Tests
```bash
rspec
```
- Includes tests for:
  - Valid pairings generation
  - File error handling (missing, malformed, incomplete data)
  - Logic to prevent invalid assignments

---

## 4 Dependencies
- Ruby 3.3+
- `csv` (stdlib)
- `fileutils` (stdlib)
- `rspec` for tests
- `rubocop` for linting (optional)

---

