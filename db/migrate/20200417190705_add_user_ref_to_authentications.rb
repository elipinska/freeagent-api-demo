class AddUserRefToAuthentications < ActiveRecord::Migration[5.2]
  def change
    add_reference :freeagent_api_authentications, :user, foreign_key: true
  end
end
