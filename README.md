# Mailsync

This is a Haskell experiment that went way better than I thought it would.
Maybe I will make this a flake later.

## What is it?

It's a simple program that runs `mbsync -a`, then counts my new email messages
and emits a DBus notification.

> You've got mail!

Souce code is in [app/Main](./app/Main.hs)
