module V1
  class Groups < Grape::API
    helpers do
      def group_params
        ActionController::Parameters.new(params).permit(:name, :comment)
      end
    end

    desc 'GET /api/v1/groups グループ一覧を取得'
    get 'groups' do
      authenticate_user!
      @user.groups
    end

    desc 'POST /api/v1/groups グループを新規作成'
    params do
      requires :name, type: String
      optional :comment, type: String
    end
    post 'groups' do
      authenticate_user!
      group = @user.groups.build(group_params)
      @user.save
    end

    desc 'GET /api/v1/groups/:id idで指定されたグループの情報を取得（不要？）'
    get 'groups/:id' do
      authenticate_user!
      group = Group.find(params[:id])
      if @user.groups.include?(group) then
        group
      else
        {message: "user doesn't participate in this group" }
      end
    end

    desc 'PUT /api/v1/groups/:id idで指定されたグループのnameとcommentを編集'
    params do
      optional :name, type: String
      optional :comment, type: String
    end
    put 'groups/:id' do
      authenticate_user!
      group = Group.find(params[:id])
      if @user.groups.include?(group) then
        group.update_attributes(group_params)
        group
      else
        {message: "user doesn't participate in this group" }
      end
    end

    desc 'DELETE /api/v1/groups/:id idで指定されたグループを削除'
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

    desc 'GET /api/v1/groups/:id/cards idで指定されたグループに含まれるカードの一覧を取得'
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

    desc 'GET /api/v1/groups/:id/users idで指定されたグループに含まれるユーザの一覧を取得'
    get 'groups/:id/users' do
      authenticate_user!
      groups = @user.groups
      group = Group.find(params[:id])
      if groups.include?(group) then
        group.users
      else
        {message: "user doesn't participate in this group" }
      end
    end

    desc 'POST /api/v1/groups/:id/users idで指定されたグループにjoin'
    post 'groups/:id/users' do
      authenticate_user!
      group = Group.find(params[:id])
      if group.users.include?(@user) then
        return { message: "User #{@user.name} already in group" }
      end
      group.users << @user
      {message: "Successfully joined to group #{group.name}!"}
    end

    desc 'DELETE /api/v1/groups/:id/users idで指定されたグループから脱退'
    delete 'groups/:id/users' do
      authenticate_user!
      group = Group.find(params[:id])
      if group.users.include?(@user) then
        UserGroup.find_by(user_id: @user.id, group_id: group.id).delete
      else
        {message: "User not in group"}
      end
    end

    desc 'PUT /api/v1/groups/:id/users/ idで指定されたグループにuser_idで指定されたユーザを追加'
    params do
      requires :user_id, type: Integer
    end
    put 'groups/:id/users' do
      authenticate_user!
      group = Group.find(params[:id])
      new_user = User.find(params[:user_id])
      if new_user != nil && group.users.include?(@user) then
        group.users << new_user
      else
        {message: "User not in group or user id #{params[:user_id]} not exists"}
      end
    end
  end
end
