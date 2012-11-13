# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

css = Category.create! name: 'CSS'
js = Category.create! name: 'JavaScript'
sql = Category.create! name: 'SQL'

sinatra = Endpoint.create! name: 'CSS / JS', url: 'http://127.0.0.1:9000'
Problem.create! category: js, name: 'Outer door', task_name: 'js_var',
                endpoint: sinatra
