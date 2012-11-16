ActiveAdmin.register Problem do
  menu parent: 'Setup'

  filter :category
  filter :endpoint, label: 'Grading endpoint'

  index download_links: false do
    column :category
    column 'UI name', :name
    column 'Endpoint name', :task_name
    column 'Grading endpoint', :endpoint

    default_actions
  end
  config.sort_order = 'name_asc'

  form do |f|
    f.inputs "Admin Details" do
      f.input :category
      f.input :name, label: 'UI name'
      f.input :task_name, label: 'Endpoint name'
      f.input :endpoint, label: 'Grading endpoint'
    end
    f.buttons
  end

  controller do
    actions :all, :except => [:show]
  end
end
