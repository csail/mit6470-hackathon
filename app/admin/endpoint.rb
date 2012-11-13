ActiveAdmin.register Endpoint, as: 'Grading Endpoint' do
  menu parent: 'Setup'

  config.filters = false

  index download_links: false do
    column :name
    column :url
    default_actions
  end
  config.sort_order = 'name_asc'

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :url
    end
    f.buttons
  end
end

