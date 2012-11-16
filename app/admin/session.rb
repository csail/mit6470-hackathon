ActiveAdmin.register Tokens::SessionUid, as: 'Session' do
  menu parent: 'Accounts'

  config.filters = false

  index download_links: false do
    column :user
    column 'IP', :browser_ip
    column 'User-Agent', :browser_ua
    column 'Last Seen', :updated_at
    default_actions
  end
  config.sort_order = 'updated_at_desc'

  controller do
    actions :index, :show, :destroy
  end
end

