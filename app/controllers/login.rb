OneBlog::App.controllers :login do
  
  #获取登录态
  before do
    if session[:current_account].blank?
      $account = []
    else
      $account = session[:current_account]
    end    
  end
  
  #注册页面
  get :register, :map => '/register' do
    @account = Account.new
    render "/login/register"
  end

  #创建新账户
  post :new, :map => '/register/new' do
    @account = Account.new(params[:account])
    if @account.save
      session[:current_account] = @account
      redirect url(:blogs, :index)
    else
      render 'login/register'
    end
  end

  #登录注册
  post :index do
    if user = Account.authenticate(params[:email], params[:password])
      session[:current_account] = user
      result = {result: 1}
      json result
    else
      params[:email] = h(params[:email])
      result = {result: 0}
      json result
    end   
  end

  #登出
  get :logout, :map =>'/logout' do
    session.clear
    redirect back
  end

  #修改个人信息页面
  get :edit, :map => '/user/edit' do
    if $account.blank?
      redirect url(:blogs, :index) 
    end  
    @account = Account.find($account[:id])
    render 'login/info_edit'
  end

  #上传头像
  get :photo do
    @account = Account.new
    render 'login/photo'
  end

  #文件上传
  post :upload do
    if params[:img] && (tempfile = params[:img][:tempfile]) && (filename = params[:img][:filename])
      unless (account = session[:current_account])
        @error = 'user not login!'
        redirect back
      end  
        pic = send_picture(tempfile, filename, account)
        if (pic.present?) && Account.update(account[:id], :photo => pic)
          flash[:success] =  ' 保存成功'
          redirect back
        end              
    else
       @error = 'No file selected'  
       redirect back
    end
   end 

  #更新个人信息
  put :update, :with => :id do
    @account = Account.find(params[:id])
    if @account
      if @account.update_attributes(params[:account])
         session[:current_account] = @account
         redirect url(:blogs,:index) 
      else
        redirect back
      end
    else
      halt 404
    end
  end

end
