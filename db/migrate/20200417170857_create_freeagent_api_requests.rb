class CreateFreeagentApiRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :freeagent_api_requests do |t|
      t.string :endpoint
      t.string :method

      t.timestamps
    end
  end
end
