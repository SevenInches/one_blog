# Helper methods defined here can be accessed in any controller or view in the application

module OneBlog
  class App
    module LoginHelper
      PUBLIC='public'
      ASSETS='/assets/images'

      def send_picture(temp, pic, account)
      	ext = File.extname(pic)
      	target = ASSETS+"/#{account[:id]}_#{account[:name]}_photo#{ext}"  
    	if File.open(PUBLIC+target, 'wb') {|f| f.write temp.read } 
    		return target
    	end	
      end	
    end

    helpers LoginHelper
  end

end
