ActiveAdmin.register Category do
  menu parent: 'Setup'

  config.filters = false

  index download_links: false do
    column 'UI name' do |category|
      best_in_place category, :name, type: :input, path: [:admin, category]
    end

    default_actions
  end
  config.sort_order = 'name_asc'

  form do |f|
    f.inputs "Admin Details" do
      f.input :name, label: 'UI name'
    end
    f.buttons
  end

  controller do
    actions :all, :except => [:show]
  end
end

