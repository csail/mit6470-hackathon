ActiveAdmin.register User do
  menu parent: 'Accounts'

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

  controller do
    actions :all, :except => [:show, :new, :create]

    def resource
      User.find_by_param params[:id]
    end
  end
end
