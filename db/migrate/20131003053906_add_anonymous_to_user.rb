class AddAnonymousToUser < ActiveRecord::Migration
  
  def up
  	anon = User.new
  	anon.login = "anonymous"
  	anon.password = 'AZaz!@12#{EDCVFR$%GB}'
  	anon.group = 'автор'
  	anon.fio = 'Аноним'
  	anon.save
  end

  def down
  	anon = User.find_by_login('anonymous')
  	anon.delete
	end

end
