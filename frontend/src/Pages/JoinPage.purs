module Pages.JoinPage where

import Prelude

import Components.JoinForm as JoinForm
import Components.Page as Page
import Data.Symbol (SProxy(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

data Query a = Const Unit

type Action = Void

type Message = Void

type State =
  {  }

type Slot = H.Slot Query Message

type ChildSlots =
  ( joinForm :: JoinForm.Slot Unit )

_joinForm :: SProxy "joinForm"
_joinForm = SProxy

component :: forall m. MonadAff m => H.Component HH.HTML Query State Message m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval }

initialState :: State -> State
initialState state = state

render :: forall m. MonadAff m => State -> HH.ComponentHTML Action ChildSlots m
render state =
  HH.div [ HP.class_ $ ClassName "page page--home" ] [ header, main ]
  where
    header = Page.header
      [ Page.title [ HH.a [ HP.href "/" ] [ HH.text "Back" ] ] ] 
    main = Page.body
      [ HH.slot _joinForm unit JoinForm.component "" absurd ]
