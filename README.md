# ig-printer

This is a little experiment I'm doing involving [webscript.io](https://www.webscript.io/).

Using [Instagram's real-time API](http://instagram.com/developer/realtime/) it subscribes to a certain hashtag, and sends any photos that are posted with that hashtag to a printer via [Google Cloud Print](https://developers.google.com/cloud-print/) where they're automatically printed.

So far this is basically just a proof of concept - the Google OAuth token is currently hard-coded into storage which means that after a certain period of time it's just going to expire and the app will stop working.

Watch this space.