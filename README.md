# 6.470 Hackathon Front-End

## Development

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
bundle exec foreman export upstart --procfile=Procfile.prod --env=config/production.env --user=$USER --port=12300
```
