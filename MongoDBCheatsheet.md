# Mongo DB Cheat Sheet

## References

- [Cheat Sheet](https://blog.codecentric.de/files/2012/12/MongoDB-CheatSheet-v1_0.pdf)
- [mongoose - elegant mongodb object modeling for node.js](http://mongoosejs.com)

## DB

```javascript
use mydb
db.users.drop();
```
## CRUDs

### Insert
```javascript
db.runCommand(
{
	insert: "users",
	documents: [ { _id: 2, user: "thoffmann", lastloggedin: null, logins: ["today", "yesterday"] } ]
})
```
### Find
```javascript
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

// Only show Name
db.users.find({}, {name:true, _id:false})
```

#### Find Operators
All operator or keywords do start with `$`
```javascript
**$gt / $gte** greater than
**$lt / $lte** lesser than
**$exists** does an attribute exist or not
**$regex** Regex
**$type** search by type
```

### Update
```javascript
db.runCommand({
	update: "users",
	updates: [{q: {user: "thoffmann"}, u: {lastloggedin: true}}]
})
```
### Delete
```javascript
db.runCommand({
	delete: "users",
	deletes: [ { q: { user: "thoffmann" }, limit: 1 } ]

})
```

## Indexes
```javascript
db.users.ensureIndex({name : 1})
```

## Replica Sets

## Sharding
Method of database partitioning