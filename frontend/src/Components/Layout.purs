module Components.Layout where

import Prelude

import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

content :: ∀ t1 t2. Array (HH.HTML t2 t1) → HH.HTML t2 t1
content =
  HH.div [ HP.class_ $ ClassName "content" ]

flexbox :: ∀ t1 t2. Array (HH.HTML t2 t1) → HH.HTML t2 t1
flexbox =
  HH.div [ HP.class_ $ ClassName "flex__box" ]