# A Realtime D3 messaging visualizer

- Database of user emails and names (many need locations added?)
- Users are given 3 messages every sunday, to distribute to coworkers.
- Realtime appending through Rails 5 actioncable/websockets

## Getting Started

```
git clone ....
redis-server (in a terminal tab)
foreman start
/localhost:5000
```

## Admin terminal

- /admin
- initial password/username set from seed file
- allows admins to see users/messages sent, and export to csv
