# Revision history for mailsync

## 0.2.0.0 -- 2023-08-14

**Breaking Changes!**
* Added the ability to configure Mailsync with 2 env vars:
  * `MAILSYNC_FOLDERS` - A globbed expression of where the new mail is supposed
    to be found. **Required**
  * `MAILSYNC_COMMAND` - The command used to sync your mail.  Defaults to
    `mbsync -a`

## 0.1.0.0 -- YYYY-mm-dd

* First version. Released on an unsuspecting world.
