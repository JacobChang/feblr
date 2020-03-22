{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "frontend"
, dependencies = [ "console", "effect", "halogen", "psci-support", "routing" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
