module V1
  class Groups < Grape::API
    helpers do
      def group_params
        ActionController::Parameters.new(params).permit(:name, :comment)
      end
    end

		desc 'GET /api/v1/groups'
		get 'groups' do
			authenticate_user!
      @user.groups
		end

    desc 'PUT /api/v1/groups'
    params do
      requires :name, type: String
      optional :comment, type: String
    end
    post 'groups' do
      authenticate_user!
      group = @user.groups.build(group_params)
      @user.save
    end

    desc 'GET /api/v1/groups/:id'
    get 'groups/:id' do
			authenticate_user!
      group = Group.find(params[:id])
      if @user.groups.include?(group) then
        group
      else
        {message: "user doesn't participate in this group" }
      end
    end

    desc'DELETE /api/v1/groups/:id'
    delete 'groups/:id' do
      authenticate_user!
      group = Group.find(params[:id])
      if @user.groups.include?(group) then
        group.destroy
        "Successfully deleted group id #{params[:id]}"
      else
        {message: "user not in group cannot delete group"}
      end
    end

    get 'groups/:id/cards' do
			authenticate_user!
      groups = @user.groups
      group = Group.find(params[:id])
      if groups.include?(group) then
        group.cards
      else
        {message: "user doesn't participate in this group" }
      end
    end
  end
end
