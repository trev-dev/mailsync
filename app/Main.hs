module Main where

import System.Directory
import System.Environment
import System.FilePath.Glob
import System.Process

import Control.Monad
import Control.Exception

import DBus.Notify
import Paths_mailsync

messageCount :: String -> IO Int
messageCount path = do
  messageDirs <- glob path
  messages <- mapM listDirectory messageDirs
  return $ length $ filter (not . null) $ concat messages

wrapNotification :: Int -> FilePath -> Note
wrapNotification count icon =
  blankNote { appName = "Mailsync"
            , summary = "You have new mail"
            , body = Just . Text $ show count ++ " messages"
            , hints = [ Category EmailArrived
                    , ImagePath $ Icon icon]}

emitNotification :: Note -> IO ()
emitNotification note = do
  client <- connectSession
  void $ notify client note

mailSyncCmd :: IO String
mailSyncCmd = do
  envCommand <- try (getEnv "MAILSYNC_COMMAND") :: IO (Either SomeException String)
  return $ case envCommand of
    Left _ -> "mailsync -a"
    Right cmd -> cmd

main :: IO ()
main = do
  newMessageDirs <- getEnv "MAILSYNC_FOLDERS";
  syncCommand <- mailSyncCmd
  callCommand syncCommand
  newMessageCount <- messageCount newMessageDirs
  when (newMessageCount > 0) $ do
    icon <- getDataFileName "envelope.png"
    emitNotification $ wrapNotification newMessageCount icon
