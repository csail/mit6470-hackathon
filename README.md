# 6.470 Hackathon Front-End

This repository contains the Rails application used to run 6.470 hackathons.


## Grading Endpoints

The 6.470 hackathon software is broken up into a Web front-end that keeps track
of users, submissions and scores, and one or many grading endpoints that
implement the problem-specific grading code. The endpoints are stateless.

The front-end talks to the endpoints using a HTTP-based protocol. Each
submission is sent to a grading endpoint via a POST request with the following
parameters:

* `task` is a problem name, such as `js-console`; endpoints have complete
control over the problem names, and the front-end admin UI allows the hackathon
staff to set up the names sent to the endpoints
* `code` is the contestant-submitted code

The grading endpoint returns a HTTP response with the following headers.

* `X-Grader-Score` is an integer between 0 and the maximum possible score
* `X-Grader-Maxscore` is an integer indicating the maximum score that the
endpoint awards for this problem set; this doesn't need to be the same as the
user-visible score
* `X-Grader-Verdict` is a brief (one-line) explanation of the score

The body of the grader's HTTP response is saved and made available to the
contestants. The response should help contestants understand the verdict, and
should be a static HTML page with no external references (use inline CSS
styles, `data:` image URLs, etc.) and no JavaScript.

The following extensions might be implemented in future protocol versions.
* `X-Grader-Warning` flagging submissions that seem to break into the grading
system, and should be reviewed
* A GET request for obtaining the list of problems implemented by a grading
endpoint, as well as the problem text in Markdown


## Development

First, follow the installation instructions for the
[sample grading endpoint](https://github.com/csail/mit6470-grader-sample). The
endpoint shares many requirements with the front-end. The endpoint should be
running during the setup process.

Get the code and its required libraries.

```bash
git checkout git@github.com:csail/mit6470-hackathon.git
cd mit6470-hackathon
bundle install
```

Set up the development database.

```bash
bundle exec rake db:create db:migrate db:seed
```

Start a development server at [http://localhost:10000](http://localhost:10000).

```bash
bundle exec foreman start
```


## Production

The initial setup is similar to the development setup.

```bash
git checkout git@github.com:csail/mit6470-hackathon.git
cd mit6470-hackathon
bundle install
RAILS_ENV=production bundle exec rake db:create db:migrate
```

The application should be set up as a system daemon.

```
sudo foreman export systemd /etc/systemd/system --procfile=Procfile.prod --env=config/production.env --user=$USER --port=12300
sudo foreman export upstart /etc/init --procfile=Procfile.prod --env=config/production.env --user=$USER --port=12300
```

