{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Handlers.Join
    ( API
    , server
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Cache.Client

data JoinPrepareRequest = JoinPrepareRequest
  { joinPrepareEmail :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''JoinPrepareRequest)

data JoinPrepareResponse = JoinPrepareResponse
  { provider :: String }

$(deriveJSON defaultOptions ''JoinPrepareResponse)

data JoinConfirmRequest = JoinConfirmRequest
  { joinConfirmEmail :: String
  , joinConfirmCode  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''JoinConfirmRequest)

data JoinConfirmResponse = JoinConfirmResponse
  { token :: String }

$(deriveJSON defaultOptions ''JoinConfirmResponse)

type API = "join" :> "request"
                  :> ReqBody '[JSON] JoinPrepareRequest
                  :> Post '[JSON] JoinPrepareResponse
      :<|> "join" :> "confirm"
                  :> ReqBody '[JSON] JoinConfirmRequest
                  :> Post '[JSON] JoinConfirmResponse

server :: Server API
server = prepare :<|> confirm
  where
    prepare :: JoinPrepareRequest -> Handler JoinPrepareResponse
    prepare request =
      return (JoinPrepareResponse "")

    confirm :: JoinConfirmRequest -> Handler JoinConfirmResponse
    confirm request = return (JoinConfirmResponse "")
