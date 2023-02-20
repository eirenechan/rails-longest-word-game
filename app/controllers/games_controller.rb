require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    # raise
    @input = params[:word].upcase.split("")
    @grid = params[:letters].split(" ")
    if in_grid?
      @message = an_english_word? ? "Congrats! #{params[:word].upcase} is a valid English word!" : "Sorry but #{params[:word].upcase} does not seem to be a valid English word."
    else
      @message = "Sorry but #{params[:word].upcase} cannot be built out of #{@grid.join(", ")}"
    end
    # @score += @input.size if in_grid? && an_english_word?

  end

  private

  def in_grid?
    @grid_check = params[:letters].split(" ")
    @input.each do |letter|
      if @grid_check.include?(letter)
        @grid_check.delete(letter)
      else
        return false
      end
    end
  end

  def an_english_word?
    input = params[:word].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    word_search = URI.open(url).read
    word = JSON.parse(word_search)
    return word["found"]
  end
end
