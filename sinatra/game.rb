require 'sinatra'

before do 
  content_type :txt
  @defeat = {rock: :scissors,paper: :rock,scissors: :paper}
  @throws = @defeat.keys
end

get '/' do
	"hello world"
end

get '/throw/:type' do
   # the params[] hash stores query string and form data
   player_throw = params[:type].to_sym
   if !@throws.include?(player_throw)
     halt 403, "You must throw one the the following #{@throws}"
   end
 
   # now we select a randow throw for the computer
   computer_throw = @throws.sample
 
   # compare the player and computer throws to determine a winner
   if player_throw == computer_throw
     "You tied with the computer. Try again!"
   elsif computer_throw == @defeat[player_throw]
     "Nicely done; #{player_throw} beats #{computer_throw}!" 
   else
     "Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!" 
   end
 
end
