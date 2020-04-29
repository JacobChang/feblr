{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Lib
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import Data.ByteString.UTF8 as BSU
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Data.Pool
import Database.PostgreSQL.Simple
import qualified Handlers.Join as Join
import Config (listenPort, connStr, postgres, backend, info, Info, Config)

index :: Config -> Info
index cfg = info cfg

type API = Get '[JSON] Info
      :<|> Join.API

type DBConnectionString = ByteString

initConnectionPool :: DBConnectionString -> IO (Pool Connection)
initConnectionPool connStr =
  createPool (connectPostgreSQL connStr)
             close
             2 -- stripes
             60 -- unused connections are kept open for a minute
             10 -- max. 10 connections open per stripe

startApp :: Config -> IO ()
startApp cfg = do
  connPool <- initConnectionPool pgConnStr
  run port (app cfg connPool)
  where
    pgConnStr = BSU.fromString $ connStr (postgres cfg)
    port = fromIntegral $ listenPort (backend cfg)

app :: Config -> Pool Connection -> Application
app cfg connPool = serve api (server cfg connPool)

api :: Proxy API
api = Proxy

server :: Config -> Pool Connection -> Server API
server cfg connPool = return (index cfg)
             :<|> Join.server cfg connPool