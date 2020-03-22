module Main where

import Prelude

import App as App
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Console (log)
import Halogen (liftEffect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Router (Page(..), router)
import Routing (match)
import Web.HTML (window)
import Web.HTML.Location (pathname)
import Web.HTML.Window (location)

parseRoute :: Effect Page
parseRoute = do
  wd <- window
  loc <- location wd
  path <- pathname loc
  log path
  case match router path of
    Left err -> pure Home
    Right route -> pure route

main :: Effect Unit
main = HA.runHalogenAff do
  route <- liftEffect $ parseRoute
  body <- HA.awaitBody
  runUI App.component route body
