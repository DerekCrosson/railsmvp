# Rails MVP

Steps to take to run the application locally and deploy to production.

### Ruby version
2.6.3

### Database creation
```
rake db:create
```

### Database initialization
```
rake db:migrate
```

### How to run the background jobs
```
bundle exec rake jobs:work
```

### How to run the test suite
```
rake test
```

### Deployment instructions
Run ```cap production deploy:check``` to make sure deployment checks pass. Then run ```cap production deploy``` to deploy to the production server. SSH key (without passphrase) must be added in the version control system and on the server to be able to access the server and code repositiory.
