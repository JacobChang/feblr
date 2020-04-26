{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import Config (Config)
import Dhall

main :: IO ()
main = do
  config <- input auto "./config.dhall"
  startApp (config :: Config)
