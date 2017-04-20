class AddUserAndChatroomIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :user_id, :string
    add_column :messages, :chatroom_id, :string
  end
end
