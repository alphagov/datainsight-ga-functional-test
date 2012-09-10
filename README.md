Functional Tests for GOV.UK Google Analytics

## Running the tests

The tests will run against the preview environment by default.  You can override that by setting the `TARGET_PLATFORM` environment variable.

You'll need to configure the http auth credentials by setting the `AUTH_USERNAME` and `AUTH_PASSWORD` environment variables.

    TARGET_PLATFORM=preview AUTH_USERNAME=username AUTH_PASSWORD=password bundle exec rake test

