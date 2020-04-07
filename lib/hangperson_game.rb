class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @count = 0
  end
  
  def word
      return @word
  end
    
  def guesses
      return @guesses
  end
    
  def wrong_guesses
      return @wrong_guesses
  end

  def guess(letter)
      
      if (letter.nil? || letter == '' || letter !~ /[[:alpha:]]/)
         raise ArgumentError
      end
      
      different = !(@guesses.include? letter)&& !(wrong_guesses.include? letter)
      lower_case = letter >= 'a' && letter <='z'
      valid = different && lower_case
      return false unless valid
      
      if @word.include? letter
          @guesses += letter
      else 
          @wrong_guesses += letter
      end
      valid
  end

  def word_with_guesses
      guessed = '-' * @word.length
    @word.each_char.with_index do |letter, index|
      guessed[index] = letter if @guesses.include? letter
    end
    guessed
  end
    
  def check_win_or_lose
    
    if(word_with_guesses == @word)
        return :win
    elsif(word_with_guesses.length >= 7)
        return :lose 
    else 
        return :play
    end
    #return :lose if @wrong_guesses.length >= 7
    
     #return :win if !word_with_guesses.index('-')  
    #:play
  end
      
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
