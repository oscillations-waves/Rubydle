# frozen_string_literal: true

module Wordle
  class Game
    def self.play(*args)
      new(*args).play
    end

    def initialize()
      @list = List.new
      @target_word = generate_word
      @result_builder = ResultBuilder.new()
    end

    def play
      winner = false

      Legend.print(@result_builder)
      puts "Guess a 5 letter word: "
      guesses = []
      must_include = []
      must_match = Array.new(5)

      while guesses.length < 6 && !winner
        guess = gets.chomp

        validator = GuessValidator.new(
          guess,
          @list
        )
        if validator.invalid?
          puts validator.error
          next
        end
        analyzer = GuessAnalyzer.new(
          @target_word,
          guess,
          @result_builder
        )
        puts analyzer.colors
        guesses << analyzer.squares

        if analyzer.match?
          winner = true
          break
        end
      end

      hash = Digest::SHA2.hexdigest(@target_word)[..5]
      if winner
        puts "\nWordle Gem #{hash} #{guesses.length}/6\n\n"
      else
        puts "\nWord was: #{@target_word}\n"
        puts "\nWordle Gem #{hash} X/6*\n\n"
      end

      puts guesses
    end

    private

    def generate_word
        @list.random
    end
  end
end
