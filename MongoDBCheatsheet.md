# Mongo DB Cheat Sheet

## Notes and others

- [elegant mongodb object modeling for node.js](http://mongoosejs.com)
- [Cheat Sheet](https://blog.codecentric.de/files/2012/12/MongoDB-CheatSheet-v1_0.pdf)

## DB

```JS
use mydb
db.users.drop();
```
## CRUDs

### Insert
```JS
db.runCommand(
{
	insert: "users",
	documents: [ { _id: 2, user: "thoffmann", lastloggedin: null, logins: ["today", "yesterday"] } ]
})
```
### Find / Select
```JS
db.runCommand({
	find: "users"
})
db.users.find()
db.users.find({user: "thoffmann"})
db.users.find({logins: "today"})

db.users.find({
	$or: [
		{"name": "myuser"},
		{"name": {"$regex": "^Pe"}}
	]
})

```
### Update
```JS
db.runCommand({
	update: "users",
	updates: [{q: {user: "thoffmann"}, u: {lastloggedin: true}}]
})
```
### Delete
```JS
db.runCommand({
	delete: "users",
	deletes: [ { q: { user: "thoffmann" }, limit: 1 } ]

})
```