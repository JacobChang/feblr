{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TemplateHaskell #-}

module Cache.Client where

import Data.Aeson
import Data.Aeson.TH
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client
import Config

data CreateTokenRequest = CreateTokenRequest
  { email :: String }

$(deriveJSON defaultOptions ''CreateTokenRequest)

data VerifyTokenRequest = VerifyTokenRequest
  { token :: String }

$(deriveJSON defaultOptions ''VerifyTokenRequest)

type TokenApi =
       "api" :> "v1" :> "tokens" :> ReqBody '[JSON] CreateTokenRequest :> PostCreated '[JSON] ()
  :<|> "api" :> "v1" :> "tokens" :> ReqBody '[JSON] VerifyTokenRequest :> Post '[JSON] ()

createToken :: CreateTokenRequest -> ClientM ()
verifyToken :: VerifyTokenRequest -> ClientM ()

api :: Proxy TokenApi
api = Proxy

createToken :<|> verifyToken = client api

runCacheClient :: CacheServer -> ClientM a -> IO (Either ClientError a)
runCacheClient server clientM = do
  manager' <- newManager defaultManagerSettings
  runClientM clientM (mkClientEnv manager' (cacheBaseUrl server))

cacheBaseUrl :: CacheServer -> BaseUrl
cacheBaseUrl server =
  BaseUrl p (host server) (fromIntegral $ port server) ""
  where
    p =
      case protocol server of
        "http" -> Http
        _ -> Https
