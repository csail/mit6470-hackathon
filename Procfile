web: bundle exec thin --address 0.0.0.0 --port $PORT --rackup config.ru start
worker: bundle exec script/delayed_job run
