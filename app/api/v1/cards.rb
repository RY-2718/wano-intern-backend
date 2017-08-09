module V1
   class Cards < Grape::API

      helpers do
         def card_params
           ActionController::Parameters.new(params).permit(:commentFront, :commentBack, :isFront, :color, :x, :y, :width, :height, :group_id)
         end
      end
     
      desc 'GET /api/v1/cards/ get the user s all cards'
      get 'cards' do
         authenticate_user!
         @user.cards
      end

      desc 'GET /api/v1/cards/{:id} get the card'
      get 'cards/:id' do
         authenticate_user!
         card = Card.find(params[:id])
         if @user.cards.include?(card) then
            card
         else
           {message: "user doesn't participate in this card" }
         end
      end
   
      desc 'PUT /api/v1/cards/:id update cards'
      put 'cards/:id' do
      params do
         optional :commentFront, type: String
      end
         authenticate_user!
         card = Card.find(params[:id])
         if @user.cards.include?(card) then
           card.update_attributes(card_params)
           card
         else
           {message: "user doesn't participate in this card" }
         end
      end

      desc 'DELETE /api/v1/cards/:id delete the IDs card'
      delete 'cards/:id' do
         authenticate_user!
         card = Card.find(params[:id])
         if @user.cards.include?(card) then
           card.destroy
           "Successfully deleted group id #{params[:id]}"
         else
           {message: "user not in group cannot delete card"}
         end
      end
 
      desc 'POST /api/v1/cards post a card'
      post 'cards' do
      params do
         requires :x, type:Integer
         requires :y, type:Integer
         requires :width, type:Integer
         requires :height, type:Integer
         optional :commentFront, type: String
      end
         authenticate_user!
         card = @user.cards.build(card_params)
         @user.save
      end		

     # desc 'PATCH /api/v1/cards/{:id}'
     # patch 'cards' do
     #     authenticate_user!			
     # end

     # desc 'DELETE /api/v1/cards/{:id}'
     # delete 'cards' do
     #     authenticate_user!			
     # end
   end
end
