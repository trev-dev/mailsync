module Main where

import System.Directory
import Data.Functor
import DBus.Notify
import System.FilePath.Glob
import Control.Monad
import System.Process
import Paths_mailsync

messageCount :: String -> IO Int
messageCount path = do
  messageDirs <- glob path
  messages <- mapM listDirectory messageDirs
  return $ length $ filter (not . null) $ concat messages

wrapNotification :: Int -> FilePath -> Note
wrapNotification count icon =
  newNote { summary="You have new mail"
          , body=Just . Text $ show count ++ " messages"
          , hints=[ Category EmailArrived
                  , ImagePath $ Icon icon]}
  where
    newNote = blankNote {appName="Mailsync"}

emitNotification :: Note -> IO ()
emitNotification note = do
  client <- connectSession
  void $ notify client note

main :: IO ()
main = do
  callProcess "mbsync" ["-a"]
  home <- getHomeDirectory
  let newMessageDirs = home ++ "/Maildir/fastmail/*/new"
  newMessageCount <- messageCount newMessageDirs
  when (newMessageCount > 0) $ do
    icon <- getDataFileName "envelope.png"
    emitNotification $ wrapNotification newMessageCount icon
