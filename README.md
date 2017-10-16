# README

The App is a simple Rails-api with basic HTTP authorization, 
using [devise](https://github.com/plataformatec/devise) and 
[simple_token_authentication](https://github.com/gonzalo-bulnes/simple_token_authentication) gems.

I decided to use this 2 gems for authrorization and authentication as they are really well maintained, and easy to use.
I could have skipped the simple token authentication and include my own solution, 
but for simplicity and a more readable and maintainable code i decide to use a public gem.


### ENDPOINTS
---

```
POST /user
```

required attributes:
`full_name`, `email`,`password`

```
POST /contract
```
require attributes:
`vendor`, `starts_on`, `ends_on`


```
GET /contract/:id
```

```
DELETE /contract/:id
```

All the endpoints for `/contract` require authentication, you should include in the request the attributes `user_email` and `user_token`
like:
```
/contract/:id?user_token=your_token&user_email=your_email
```
or you can add them at the request header
```
X-User-Email your_email
X-User-Token your_token
```
---

### Running the API

To run the api locally you need to: 
1. first clone the repo
2. run `bundle install`
3. migrate the db `rails db:migrate`
4. run the server `rails server`

For sending request to the api, you can use [Postman](https://www.getpostman.com/)

### Runing test

For testing I am using `rspec-rails` gem

You need to run `bundle exec rspec` for running all the tests
