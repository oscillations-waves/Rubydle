# frozen_string_literal: true

module Wordle
  class GuessValidator
    def initialize(
      guess,
      list
    )
      @guess = guess
      @list = list
      @validated = false
    end

    def invalid?
      !error.nil?
    end

    def error
      validate if !@validated

      @error
    end

    private

    def validate
      validate_length
      @validated = true
    end

    def validate_length
      if @guess.length != 5
        @error = "Guess must be 5 letters long"
      elsif @list.invalid?(@guess)
        @error = "Guess not in word list"
      end
    end

  end
end
