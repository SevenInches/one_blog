OneBlog::App.controllers :blogs do

  $demo_photo = '/images/avatar.png'

  #博客首页
  get :index, :map =>'/' do
    @title = '热门博客'
    if params[:page].nil?
      params[:page] = 1
    end
    @blogs = Blog.order('created_at desc').page(params[:page]).per(4)
    if @blogs
      @hot_users = get_hot_users(4)
      @tags = Tag.limit(12).all()
      render 'blogs/index'
    else
      halt 404
    end    
  end

  #博客详情页
  get :detail, :with => :id do
    begin
      @blog = Blog.find(params[:id])
      if @blog
        @blog.add_view()
        render 'blogs/detail'
       end
    rescue
      redirect url(:blogs, :index)
     end       
  end

  #用户博客列表页
  get :user, :with => :id do
      if params[:page].nil?
        params[:page] = 1
      end
      begin  
        @blogs = Blog.order('created_at desc').where(:account_id => params[:id]).page(params[:page]).per(4)
        if @blogs 
          @user = @blogs.first.account
          @title = @user.blog_name
          render 'blogs/user_blog'
        end  
      rescue
        redirect url(:blogs, :index)
      end    
  end

  #标签博客列表页
  get :tag, :with => :id do
    if params[:page].nil?
      params[:page] = 1
    end
    begin  
      @blogs = Blog.order('created_at desc').where(:tag => params[:id]).page(params[:page]).per(4)
      if @blogs
        @tags = Taglimit(12).all()
        render 'blogs/tag_blog'
      end  
     rescue
       redirect url(:blogs, :index)
     end   
  end

  #新建博客页面
  get :new do
    unless $account.present?
      redirect url(:blogs, :index)
    end
    @blog_tags=Tag.find_tags  
    @blog = Blog.new
    render 'blogs/new'
  end  

  #用户博客列表
  get :list do 
    unless $account.present?
      redirect url(:blogs, :index)
    end
    if params[:page].nil?
        params[:page] = 1
    end
    @account = $account 
    @blogs = Blog.order('created_at desc').where(:account_id => @account[:id]).page(params[:page]).per(10)
    if @blogs
      render 'blogs/list'
    else
       halt 404
     end  
  end
  
  #热门用户列表页
  get :hot do
    @title = "Accounts"
    id_list = get_hot_account()
    @hot_users = Account.find(id_list)
    render 'blogs/users'
  end

  #用户博客修改
  get :edit, :with => :id do
    @blog = Blog.find(params[:id])
    @blog_tags=Tag.find_tags()
    if @blog
      render 'blogs/edit'
    else  
      halt 404
    end
  end
  
  #创建新的博客
  post :create do
    @blog = Blog.new(params[:blog])
    if @blog.save
      redirect url(:blogs, :index)
    else
      render 'blogs/new'
    end
  end

  #更新博客信息
  put :update, :with => :id do
    @blog = Blog.find(params[:id])
    if @blog
      if @blog.update_attributes(params[:blog])
          redirect(url(:blogs, :index))
      else
        render 'blogs/edit'
      end
    else
      halt 404
    end
  end

  #删除博客信息
  get :delete, :with => :id do
    puts params[:id]
    @blog = Blog.find(params[:id])
    if @blog
      @blog.destroy
      redirect url(:blogs,:list)
    else
      halt 404
    end
  end
       
end
   