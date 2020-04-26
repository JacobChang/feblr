{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Lib
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import qualified Handlers.Join as Join
import Config (listenPort, backend, info, Info, Config)

index :: Config -> Info
index cfg = info cfg

type API = Get '[JSON] Info
      :<|> Join.API

startApp :: Config -> IO ()
startApp cfg =
  run port (app cfg)
  where
    port = fromIntegral $ listenPort (backend cfg)

app :: Config -> Application
app cfg = serve api (server cfg)

api :: Proxy API
api = Proxy

server :: Config -> Server API
server cfg = return (index cfg)
        :<|> Join.server