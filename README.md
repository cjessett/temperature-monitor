# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
 ```config/local_env.yml```
 ```
SNS_ROLE_ARN: <AWS_SNS_SERVICE_ROLE_ARN>
ENDPOINT: <AWS_IOT_ENDPOINT>
AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
 ```

* Database creation
```
bundle
rails db:setup
bundle exec rails server
```

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
