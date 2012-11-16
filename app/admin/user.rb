ActiveAdmin.register User do
  menu parent: 'Accounts'

  index do
    column :email
    column 'Administrator' do |user|
      best_in_place user, :admin, type: :checkbox, path: [:admin, user]
    end
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
      User.with_param(params[:id]).first!
    end
  end
end
