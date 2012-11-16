ActiveAdmin.register Problem do
  menu parent: 'Setup'

  filter :category
  filter :endpoint, label: 'Grading endpoint'

  index download_links: false do
    column :category do |problem|
      best_in_place problem, :category_id, type: :select,
          path: [:admin, problem],
          collection: Category.all.map { |c| [c.id, c.name] }
    end
    column 'UI name' do |problem|
      best_in_place problem, :name, type: :input, path: [:admin, problem]
    end
    column 'Endpoint name', :task_name
    column 'Grading endpoint', :endpoint
    column 'Published' do |problem|
      best_in_place problem, :published, type: :checkbox,
          path: [:admin, problem]
    end

    default_actions
  end
  config.sort_order = 'name_asc'

  form do |f|
    f.inputs "Admin Details" do
      f.input :category
      f.input :name, label: 'UI name'
      f.input :task_name, label: 'Endpoint name'
      f.input :endpoint, label: 'Grading endpoint'
      f.input :published, label: 'Published'
      f.input :description_html, label: 'Description HTML'
    end
    f.buttons
  end

  controller do
    actions :all, :except => [:show]
  end
end
