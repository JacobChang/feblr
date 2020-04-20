{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Cache.Client where

import Data.Aeson
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client

data CreateTokenRequest = CreateTokenRequest
  { email :: String }

data CreateTokenResponse = CreateTokenResponse
  { email :: String }

createToken :: String -> IO String
createToken email = return email
