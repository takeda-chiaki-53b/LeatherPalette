class RemoveProductNameAndProductNameId < ActiveRecord::Migration[7.2]
  def change
    # productsテーブルからproduct_name_idカラムに対する外部キー制約を削除
    remove_foreign_key :products, :product_names if foreign_key_exists?(:products, :product_names)

    # productsテーブルからproduct_name_idカラムの削除
    remove_column :products, :product_name_id, :bigint

    # product_namesテーブルの削除
    drop_table :product_names
  end
end
