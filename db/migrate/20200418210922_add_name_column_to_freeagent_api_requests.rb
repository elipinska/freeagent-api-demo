class AddNameColumnToFreeagentApiRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :freeagent_api_requests, :name, :string
  end
end
