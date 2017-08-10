module V1
   class Cards < Grape::API

      helpers do
         def card_params
           ActionController::Parameters.new(params).permit(:commentFront, :commentBack, :isFront, :color, :x, :y, :width, :height, :created_at, :updated_at, :group_id)
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
      params do
         optional :commentFront, type: String
         optional :commentBack, type: String
         optional :color, type: String
         optional :x, type: Integer
         optional :y, type: Integer
         optional :width, type: Integer
         optional :height, type: Integer
         optional :isFront, type: Boolean
      end
      put 'cards/:id' do
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
      params do
         requires :x, type: Integer
         requires :y, type: Integer
         requires :width, type: Integer
         requires :height, type: Integer
         requires :isFront, type: Boolean
         optional :commentFront, type: String
         optional :commentBack, type: String
         optional :color, type: String
         requires :group_id, type: Integer
      end
      post 'cards' do
         authenticate_user!
         card = @user.cards.build(card_params)
         group = Group.find(:group_id)
         group.cards << card
         group.save
         @user.save
      end		
   end
end
