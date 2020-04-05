module Main where

import Prelude

import App (Query(..))
import App as App
import Control.Coroutine as CR
import Control.Coroutine.Aff as CRA
import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Console (log)
import Halogen (liftEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Router (Page, parse)
import Web.Event.EventTarget as EventTarget
import Web.HTML as HTML
import Web.HTML.Event.HashChangeEvent as HCE
import Web.HTML.Event.HashChangeEvent.EventTypes as HCET
import Web.HTML.Location as Location
import Web.HTML.Window as Window

hashChangeProducer :: CR.Producer HCE.HashChangeEvent Aff Unit
hashChangeProducer = CRA.produce \emitter -> do
  listener <- EventTarget.eventListener (traverse_ (CRA.emit emitter) <<< HCE.fromEvent)
  liftEffect $
    HTML.window
      >>= Window.toEventTarget
      >>> EventTarget.addEventListener HCET.hashchange listener false

hashChangeConsumer
  :: (forall a. App.Query a -> Aff (Maybe a))
  -> CR.Consumer HCE.HashChangeEvent Aff Unit
hashChangeConsumer query = CR.consumer \event -> do
  let hash = HCE.newURL event
  void $ query $ H.tell $ ChangeUrl hash
  pure Nothing

parseRoute :: Effect Page
parseRoute = do
  win <- HTML.window
  loc <- Window.location win
  path <- Location.pathname loc
  log path
  pure $ parse path

main :: Effect Unit
main = HA.runHalogenAff do
  route <- liftEffect $ parseRoute
  body <- HA.awaitBody
  runUI App.component route body
