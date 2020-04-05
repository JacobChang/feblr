module Components.Page where

import Prelude

import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Components.Layout as Layout

header :: ∀ t1 t2. Array (HH.HTML t2 t1) → HH.HTML t2 t1
header content =
  HH.div [ HP.class_ $ ClassName "page__header" ] [ Layout.content content ]

title :: ∀ t1 t2. Array (HH.HTML t2 t1) → HH.HTML t2 t1
title =
  HH.h4 [ HP.class_ $ ClassName "page__title" ]

body :: ∀ t1 t2. Array (HH.HTML t2 t1) → HH.HTML t2 t1
body content =
  HH.div [ HP.class_ $ ClassName "page__body" ] [ Layout.content content ]