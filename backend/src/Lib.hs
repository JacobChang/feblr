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

data Backend = Backend
  { backendName     :: String
  , backendVersion  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''Backend)

backend :: Backend
backend = Backend "Feblr Backend" "0.0.1"

type API = Get '[JSON] Backend
      :<|> Join.API

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
<<<<<<< HEAD
server = return users

users :: [User]
users = [ User 1 "Isaac" "Newton"
        , User 2 "Albert" "Einstein"
        ]
=======
server = return backend
    :<|> Join.server

>>>>>>> update
