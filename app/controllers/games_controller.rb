require 'open-uri'

class GamesController < ApplicationController
  def new
    nb_letters = 10
    @letters = ('A'..'Z').to_a.sample(nb_letters)
    p @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    res_serialized = URI.open(url).read
    res = JSON.parse(res_serialized)

    if res['word'].chars.all? { |letter| params[:letters].delete(' ').downcase.include?(letter) }
      if res['found'] == true
        @points = res.length * 4
        @page_response = "Congratulation, you marked #{@points} points!"
      else
        @page_response = 'This word does not exist'
      end
    else
      @page_response = 'You must use specified letters only'
    end
  end
end
