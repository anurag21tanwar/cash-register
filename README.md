# Anurag's cash-register-hw

Hi,

app info:
1) cash-register-hw rails app uses rails 6.1.4 and ruby 2.7.0
2) rubocop for code quality
3) rspec for unit tests
4) react and bootstrap for ui.
5) psql for db
6) simplecov for test coverage

models:
1) products i.e [code, name, price]
2) products are pre-seeded
3) basket join products and items
4) basket maintains a session, expires in 1 hour
5) items i.e [quantity, amount]

test:
1) to see test coverage, go to open tmp/coverage/index.html

todo:
1) make Dockerfile
2) test cases for react using enzyme

deployed on heroku: http://cash-register-hw.herokuapp.com
