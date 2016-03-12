OneBlog::Admin.controllers :blogs do
  get :index do
    @title = "Blogs"
    @blogs = Blog.all
    render 'blogs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'blog')
    @tags=Tag.find_tags
    @blog = Blog.new
    render 'blogs/new'
  end

  post :create do
    @blog = Blog.new(params[:blog])
    if @blog.save
      @title = pat(:create_title, :model => "blog #{@blog.id}")
      flash[:success] = pat(:create_success, :model => 'Blog')
      params[:save_and_continue] ? redirect(url(:blogs, :index)) : redirect(url(:blogs, :edit, :id => @blog.id))
    else
      @title = pat(:create_title, :model => 'blog')
      flash.now[:error] = pat(:create_error, :model => 'blog')
      render 'blogs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "blog #{params[:id]}")
    @tags=Tag.find_tags
    @blog = Blog.find(params[:id])
    if @blog
      render 'blogs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "blog #{params[:id]}")
    @blog = Blog.find(params[:id])
    if @blog
      if @blog.update_attributes(params[:blog])
        flash[:success] = pat(:update_success, :model => 'Blog', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:blogs, :index)) :
          redirect(url(:blogs, :edit, :id => @blog.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'blog')
        render 'blogs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Blogs"
    blog = Blog.find(params[:id])
    if blog
      if blog.destroy
        flash[:success] = pat(:delete_success, :model => 'Blog', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'blog')
      end
      redirect url(:blogs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Blogs"
    unless params[:blog_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'blog')
      redirect(url(:blogs, :index))
    end
    ids = params[:blog_ids].split(',').map(&:strip)
    blogs = Blog.find(ids)
    
    if Blog.destroy blogs
    
      flash[:success] = pat(:destroy_many_success, :model => 'Blogs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:blogs, :index)
  end
end
