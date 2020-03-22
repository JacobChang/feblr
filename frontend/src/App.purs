module App where

import Prelude

import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import Router (Page(..))

type State =
  { page :: Page }

type Action = Void

data Query a = Const Unit

type Message = Void

component :: H.Component HH.HTML Query Page Message Aff
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval
    }
  where
    initialState :: Page -> State
    initialState page = { page }

    render :: State -> H.ComponentHTML Action () Aff
    render state =
      let
        label =
          case state.page of
            Home -> "Home Page"
            Join -> "Join Page"
            Profile -> "Profile Page"
      in
        HH.div [] [ HH.text label ]
