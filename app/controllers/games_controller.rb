require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { |_| @letters << ('A'..'Z').to_a.sample }
  end

  def score
    answer = params['game_answer']
    letters = params['letters']
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    data = URI.open(url).read
    result = JSON.parse(data)

    if result['found'] && valid?(letters, answer)
      @score = "Congratulations! #{answer} is a valid English word!"
    elsif result['found'] && valid?(letters, answer) == false
      @score = "Sorry but #{answer} can't be built out of #{letters}"
    else
      @score = "Sorry but #{answer} does not seem to be a valid English word..."
    end
  end

  def valid?(letters, answer)
    answer.upcase.each_char do |char|
      return false unless letters.include? char
    end
    return true
  end
end
