admin = Admin.create! name: "Maxim", email: "my@email.de", password: "Test1234", superadmin: true

Event.create! name: "Interactive Cologne", card_uid: true, resource: true, url: "http://localhost:3001/", admin: admin

YetAnotherKard.create! uid: "4931082332032128"
YetAnotherKard.create! uid: "4612867186"