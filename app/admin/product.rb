ActiveAdmin.register Product do
  actions :index, :edit, :update, :create, :destroy, :new

  permit_params :product_name, :product_description, :product_price, :category_id

  filter :product_name

  filter :product_description

  filter :product_price

  filter :category_id

end


