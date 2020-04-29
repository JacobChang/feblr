{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Handlers.Join
    ( API
    , server
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Data.Pool
import Database.PostgreSQL.Simple
import Control.Monad.IO.Class
import Servant
import Servant.Client
import Cache.Client
import Config

data JoinPrepareRequest = JoinPrepareRequest
  { email :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''JoinPrepareRequest)

data JoinConfirmRequest = JoinConfirmRequest
  { email :: String
  , token :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''JoinConfirmRequest)

type API = "api" :> "v1" :> "join" :> "request"
                  :> ReqBody '[JSON] JoinPrepareRequest
                  :> PostCreated '[JSON] ()
      :<|> "api" :> "v1" :> "join" :> "confirm"
                  :> ReqBody '[JSON] JoinConfirmRequest
                  :> Post '[JSON] ()

server :: Config -> Pool Connection -> Server API
server cfg connPool = prepare :<|> confirm
  where
    prepare :: JoinPrepareRequest -> Handler ()
    prepare request = do
      res <- liftIO $ runCacheClient (cacheServer cfg) query
      respond res
      where
        query = createToken (CreateTokenRequest (email (request::JoinPrepareRequest)))
        respond :: Either ClientError () -> Handler ()
        respond res =
          case res of
            Left error ->
              throwError err500
            Right res ->
              return ()

    confirm :: JoinConfirmRequest -> Handler ()
    confirm request = return ()
