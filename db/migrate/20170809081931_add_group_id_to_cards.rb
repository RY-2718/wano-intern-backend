class AddGroupIdToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :group, index: true, foreign_key: true
  end
end
