class ApplicationController < Sinatra::Base

  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
  end

    # use the :id syntax to create a dynamic route
    get '/games/:id' do
      # look up the game in the database using its ID
      game = Game.find(params[:id])
      # send a JSON-formatted response of the game data 
      game.to_json
      #including associated reviews
      game.to_json(include: :reviews)
      # users associated with reviews 
      game.to_json(include: {reviews: {include: :user}})
      # select certain attributes
      game.to_json(only: [:id, :title, :genre, :price], include: {
        reviews: {only: [:comment, :score], include: {
          user: {only: [:name]}
        }}
      })
    end

end
