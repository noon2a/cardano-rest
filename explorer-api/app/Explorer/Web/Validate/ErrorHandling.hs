{-# LANGUAGE OverloadedStrings #-}

module Explorer.Web.Validate.ErrorHandling
  ( handleLookupFail
  , handleExplorerError
  ) where

import Cardano.Db
    ( LookupFail, renderLookupFail )
import Control.Monad.IO.Class
    ( MonadIO, liftIO )
import Data.Text.ANSI
    ( red )
import Explorer.Web.Error
    ( ExplorerError (..), renderExplorerError )
import System.Exit
    ( exitFailure )

import qualified Data.Text.IO as Text

handleLookupFail :: MonadIO m => Either LookupFail a -> m a
handleLookupFail ela =
  case ela of
    Left err -> liftIO $ do
                  Text.putStrLn $ red (renderLookupFail err)
                  exitFailure
    Right v -> pure v

handleExplorerError :: MonadIO m => Either ExplorerError a -> m a
handleExplorerError eea =
  case eea of
    Left err -> liftIO $ do
                  Text.putStrLn $ red (renderExplorerError err)
                  exitFailure
    Right v -> pure v
