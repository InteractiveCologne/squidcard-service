admin = Admin.create! name: "Maxim", email: "my@email.de", password: "Test1234", superadmin: true

Event.create! name: "Interactive Cologne", card_uid: true, resource: true, url: "http://localhost:3001/checkin", admin: admin

YetAnotherKard.create! uid: "4931082332032128"
YetAnotherKard.create! uid: "4612867186"
YetAnotherKard.create! uid: "1782815410"
YetAnotherKard.create! uid: "1945515810"
YetAnotherKard.create! uid: "11424515810"
YetAnotherKard.create! uid: "14216255187"
