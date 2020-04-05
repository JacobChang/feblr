module Pages.NotFoundPage where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

data Query a = Const Unit

type Action = Void

type Message = Void

type State =
  {  }

type Slot = H.Slot Query Message

component :: forall m. H.Component HH.HTML Query State Message m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval }

initialState :: State -> State
initialState state = state

render :: forall m. State -> HH.ComponentHTML Action () m
render state =
  HH.div [] [ HH.text "NotFound Page" ]
