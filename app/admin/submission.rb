ActiveAdmin.register Submission do
  filter :problem
  filter :user

  index download_links: false do
    column 'Time' do |submission|
      submission.created_at.strftime('%H:%M:%S')
    end
    column :problem
    column :user
    column :score
    column :max_score, label: 'Max. score'
    column :verdict_message, label: 'Verdict'
  end
  config.sort_order = 'created_at_asc'

  form do |f|
    f.inputs "Admin Details" do
      f.input :problem
      f.input :user
      f.input :score
      f.input :max_score, label: 'Max. score'
      f.input :verdict_message, label: 'Verdict'
    end
    f.buttons
  end
end

