admin = Admin.create! name: "Max", email: "my@email.de", password: "Test1234", superadmin: true

Event.create! name: "Interactive Cologne", key: "SomethingReallyRandom", card_uid: true, resource: true, url: "http://localhost:3001/gallerie.json", admin: admin

SquidCard.create! uid: "4931082332032128"
SquidCard.create! uid: "4612867186"