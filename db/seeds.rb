# This file should contain all the record creation needed to seed the database
# with its default values.
#
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).

css = Category.create!({ name: 'CSS' }, as: :active_admin)
js = Category.create!({ name: 'JavaScript' }, as: :active_admin)
sql = Category.create!({ name: 'SQL' }, as: :active_admin)

sinatra = Endpoint.create!({ name: 'CSS / JS Sample Endpoint',
    url: 'http://127.0.0.1:9000' }, as: :active_admin)
js_start = <<END_JS
// Add your code below.
END_JS
js_problem = Problem.create!({ category: js, name: 'JS console',
    task_name: 'js_console', endpoint: sinatra, weight: 350, published: true,
    description_html: <<END_HTML, starter_code: js_start }, as: :active_admin)
<p>Hello world problem description.</p>
<p>This can contain <em>any</em> HTML tag.</p>
END_HTML

admin = User.new email: 'admin@mit.edu', password: 'mit',
                 password_confirmation: 'mit', team_name: 'Staff 1'
admin.admin = true
admin.save!

user = User.create! email: 'user@mit.edu', password: 'mit',
                    password_confirmation: 'mit', team_name: '1337 Hackers'

js_submission = Submission.new problem: js_problem, code: <<END_CODE
console.log("Hello world");
END_CODE
js_submission.user = user
js_submission.remote_ip = '127.0.0.1'
js_submission.save!

js_submission.grade!
Kernel.system 'rake jobs:clear'

