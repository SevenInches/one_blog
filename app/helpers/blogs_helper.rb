# Helper methods defined here can be accessed in any controller or view in the application

module OneBlog
  class App
    module BlogsHelper
        # 获取热门博客的用户id
		def get_hot_account limit=8 
    	  id_list = Array.new
    	  users = Blog.find_by_sql("select account_id from blogs group by account_id order by view desc limit "+limit.to_s)
    	  users.each do |u|
    		  id_list.push(u.account_id)
    	  end
    	  return id_list
    	end
        
        # 获取热门用户
        def get_hot_users limit=8
          id_list = get_hot_account(limit)
          if id_list
            Account.find(id_list)
          else
            Array.new()
          end 
        end
    end
    helpers BlogsHelper
  end
end
