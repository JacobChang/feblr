module Pages.HomePage where

import Prelude

import Components.Page as Page
import Effect.Aff.Class (class MonadAff)
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

data Query a = Const Unit

data Action = LoadTimelines Int Int

type Message = Void

type State =
  { isLoading :: Boolean }

type Slot = H.Slot Query Message

component :: forall m. MonadAff m => H.Component HH.HTML Query State Message m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction } }

initialState :: State -> State
initialState state = state

render :: forall m. State -> HH.ComponentHTML Action () m
render state =
  HH.div [ HP.class_ $ ClassName "page page--home" ] [ header, main ]
  where
    header = Page.header
      [ Page.title [ HH.text "Feblr" ]
      , HH.a [ HP.href "/join" ] [ HH.text "Join" ] ] 
    main = Page.body
      [ HH.text "Home Page" ]


handleAction :: forall m. MonadAff m => Action -> H.HalogenM State Action () Message m Unit
handleAction action =
  case action of
    LoadTimelines offset limit -> do
      H.modify_ (_ { isLoading = true })
      H.modify_ (_ { isLoading = false })