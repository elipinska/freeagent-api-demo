class CreateFreeagentApiAuthentications < ActiveRecord::Migration[5.2]
  def change
    create_table :freeagent_api_authentications do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
