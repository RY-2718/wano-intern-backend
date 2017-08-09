module V1
  class Groups < Grape::API
		desc 'GET /api/v1/groups'
		get 'groups' do
			authenticate_user!
      @user.groups
		end

    get 'groups/:id' do
			authenticate_user!
      groups = @user.groups
      group = Groups.find(params[:id])
      if groups.include?(group) then
        group
      else
        {message: "user doesn't participate in this group" }
      end
    end

    get 'groups/:id/cards' do
			authenticate_user!
      groups = @user.groups
      group = Groups.find(params[:id])
      if groups.include?(group) then
        group.cards
      else
        {message: "user doesn't participate in this group" }
      end
    end
  end
end
