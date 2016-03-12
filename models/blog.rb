class Blog < ActiveRecord::Base
	belongs_to :account
	belongs_to :tag
	validates_presence_of :title
    validates_presence_of :body

    def add_view
    	view = self.view.to_i
        self.view = view + 1
        self.save 
    end     
end
