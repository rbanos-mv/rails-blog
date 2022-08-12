class AddDefaultValues < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :posts_count, 0
    change_column_default :posts, :comments_count, 0
    change_column_default :posts, :likes_count, 0
  end

  def down
    change_column_default :users, :posts_count, nil
    change_column_default :posts, :comments_count, nil
    change_column_default :posts, :likes_count, nil
  end
end
