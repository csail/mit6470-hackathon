# 6.470 Hackathon Front-End

## Development

First, follow the installation instructions for the
[sample grading endpoint](https://github.com/csail/mit6470-grader-sample).
Asides from get

Initial setup.

```bash
bundle
bundle exec rake db:create db:migrate db:seed
```

Start a development server at [http://localhost:10000](http://localhost:10000).

```bash
bundle exec foreman start
```

## Production

Initial setup.

```bash
bundle
RAILS_ENV=production bundle exec rake db:create db:migrate db:seed
```

Daemon setup.

```
sudo foreman export systemd /etc/systemd/system --procfile=Procfile.prod --env=config/production.env --user=$USER --port=12300
sudo foreman export upstart /etc/init --procfile=Procfile.prod --env=config/production.env --user=$USER --port=12300
```
