{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}

module Config where

import Dhall
import GHC.Generics
import Data.Aeson
import Data.Aeson.TH

data Info = Info
  { name :: String
  , version :: String }
  deriving (Generic, Show)

$(deriveJSON defaultOptions ''Info)

instance FromDhall Info

data Backend = Backend
  { listenPort :: Natural }
  deriving (Generic, Show)

instance FromDhall Backend

data Postgres = Postgres
  { connStr :: String }
  deriving (Generic, Show)

instance FromDhall Postgres

data CacheServer = CacheServer
  { addr :: String
  , clientId :: String
  , clientSecret :: String }
  deriving (Generic, Show)

instance FromDhall CacheServer

data Config = Config
  { info :: Info
  , backend :: Backend
  , postgres :: Postgres
  , cacheServer :: CacheServer }
  deriving (Generic, Show)

instance FromDhall Config