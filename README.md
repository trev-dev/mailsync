# Mailsync

This is a Haskell experiment that went way better than I thought it would.

## What is it?

It's a simple program that runs `mbsync -a`, then counts my new email messages
and emits a DBus notification.  My only plan at the moment is to support the
maildir format.

> You've got mail!

Souce code is in [app/Main](./app/Main.hs)

## Configuration

Set the following environment variables to configure this app:

- `MAILSYNC_FOLDERS` - a globbed path expression as to where the new mail is
  located.  For example: `/home/bob/Maildir/account/*/new`
- `MAILSYNC_COMMAND` - an optional custom command for syncing your mail.
  Default: `mbsync -a`
