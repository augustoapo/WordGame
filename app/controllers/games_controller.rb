require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { (('A'..'Z').to_a).sample }
    @letters = @letters.shuffle!
  end
  def score
    @word = params[:word]
    @letters = params[:letters]
    
    run_game(@word, @letters)
  end
  def run_game(attempt, grid)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_text = URI.open(url).read
    user = JSON.parse(user_text)
    hash = {}
    puts user
    if user["found"]
      wordarray = user["word"].upcase.chars
      if wordarray.all? { |letter| wordarray.count(letter.upcase) <= grid.count(letter.upcase) }
        @message = "well done"
      else
        @message = "not in the grid"
      end
    else
      @message =  "not an english word"
    end
  end
end
