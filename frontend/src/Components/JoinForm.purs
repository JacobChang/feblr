module Components.JoinForm where

import Prelude

import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Web.Event.Event (preventDefault)
import Web.Event.Internal.Types (Event)

type Input = String

data Query a = Const Unit

data Action
  = UpdateEmail String
  | Submit Event

type Message = Void

type State =
  { isSubmitting :: Boolean
  , email :: String }

type Slot = H.Slot Query Message

component :: forall m. MonadAff m => H.Component HH.HTML Query String Message m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }}

initialState :: String -> State
initialState email = { email, isSubmitting: false }

render :: forall m. State -> HH.ComponentHTML Action () m
render state =
  HH.form
    [ HP.class_ $ ClassName "form form--join"
    , HE.onSubmit (Just <<< Submit) ]
    [ HH.h3 [ HP.class_ $ ClassName "form__title" ] [ HH.text "Feblr" ]
    , HH.div [ HP.class_ $ ClassName "form__field" ]
        [ HH.input
            [ HP.class_ $ ClassName "form__control"
            , HP.value state.email
            , HP.placeholder "Your email"
            , HE.onValueInput \email -> Just (UpdateEmail email) ] ]
    , HH.div [ HP.class_ $ ClassName "form__submit" ]
        [ HH.button
            [ HP.class_ $ ClassName "form__control button button--primary button--solid"
            , HP.disabled state.isSubmitting ]
            [ HH.text "Join" ] ] ]

handleAction :: forall m. MonadAff m => Action -> H.HalogenM State Action () Message m Unit
handleAction action =
  case action of
    UpdateEmail email -> do
      H.modify_ (\st -> st { email = email })
    Submit evt -> do
      H.liftEffect $ preventDefault evt
      email <- H.gets _.email
      H.modify_ (_ { isSubmitting = true })
      H.modify_ (_ { isSubmitting = false })