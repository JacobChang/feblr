module Router where

import Prelude

import Control.Alternative ((<|>))
import Routing.Match (Match, lit)

data Page
  = Home
  | Join
  | Profile

root :: Match Unit
root = lit ""

matchHome :: Match Page
matchHome = Home <$ root

matchJoin :: Match Page
matchJoin = Join <$ (root *> lit "join")

matchProfile :: Match Page
matchProfile = Profile <$ (root *> lit "profile")

router :: Match Page
router = matchHome <|> matchJoin <|> matchProfile
