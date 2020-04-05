module App where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Pages.HomePage as HomePage
import Pages.JoinPage as JoinPage
import Pages.NotFoundPage as NotFoundPage
import Pages.ProfilePage as ProfilePage
import Router (Page(..), parse)

type State =
  { page :: Page }

type Action = Void

data Query a
  = ChangeUrl String a

type Message = Void

type ChildSlots =
  ( notFoundPage :: NotFoundPage.Slot Unit
  , homePage :: HomePage.Slot Unit
  , joinPage :: JoinPage.Slot Unit
  , profilePage :: ProfilePage.Slot Unit )

_notFoundPage :: SProxy "notFoundPage"
_notFoundPage = SProxy

_homePage :: SProxy "homePage"
_homePage = SProxy

_joinPage :: SProxy "joinPage"
_joinPage = SProxy

_profilePage :: SProxy "profilePage"
_profilePage = SProxy

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

    render :: State -> H.ComponentHTML Action ChildSlots Aff
    render state =
      let
        page =
          case state.page of
            NotFound ->
              HH.slot _notFoundPage unit NotFoundPage.component {} absurd
            Home ->
              HH.slot _homePage unit HomePage.component { isLoading: false } absurd
            Join ->
              HH.slot _joinPage unit JoinPage.component {} absurd
            Profile ->
              HH.slot _profilePage unit ProfilePage.component {} absurd
      in
        HH.div [ HP.class_ $ HH.ClassName "app" ] [ page ]

handleQuery :: forall act o m a. Query a -> H.HalogenM State act () o m (Maybe a)
handleQuery = case _ of
  ChangeUrl url a -> do
    H.modify_ \st -> { page: parse url }
    pure (Just a)