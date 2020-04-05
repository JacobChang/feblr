module Router where

import Prelude

import Control.Alternative ((<|>))
import Data.Either (Either(..))
import Routing (match)
import Routing.Match (Match, end, lit)

data Page
  = NotFound
  | Home
  | Join
  | Profile

matchHome :: Match Page
matchHome = Home <$ (lit "" <* end)

matchJoin :: Match Page
matchJoin = Join <$ (lit "" <* lit "join")

matchProfile :: Match Page
matchProfile = Profile <$ (lit "" <* lit "profile")

router :: Match Page
router = matchHome <|> matchJoin <|> matchProfile

parse :: String -> Page
parse url =
  case match router url of
    Left err -> NotFound
    Right page -> page