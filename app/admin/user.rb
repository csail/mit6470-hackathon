ActiveAdmin.register User do
  index do
    column :email
    column :admin, label: 'Administrator'
    default_actions
  end

  filter :admin, label: 'Administrator'
  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :admin, label: 'Administrator'
    end
    f.buttons
  end
end
