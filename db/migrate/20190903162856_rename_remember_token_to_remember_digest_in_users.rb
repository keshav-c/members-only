class RenameRememberTokenToRememberDigestInUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :remember_token, :remember_digest
    end
  end
end
