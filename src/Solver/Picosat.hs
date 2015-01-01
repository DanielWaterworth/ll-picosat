{-# LANGUAGE ForeignFunctionInterface #-}
module Solver.Picosat where

import Foreign.C
import Foreign.Ptr

data Solver

foreign import ccall "picosat_init" picosat_init :: IO (Ptr Solver)
foreign import ccall "picosat_reset" picosat_reset :: Ptr Solver -> IO ()
foreign import ccall "picosat_add" picosat_add :: Ptr Solver -> CInt -> IO CInt
foreign import ccall "picosat_sat" picosat_sat :: Ptr Solver -> CInt -> IO CInt
foreign import ccall "picosat_deref" picosat_deref :: Ptr Solver -> CInt -> IO CInt
foreign import ccall "picosat_inc_max_var" picosat_inc_max_var :: Ptr Solver -> IO CInt
foreign import ccall "picosat_push" picosat_push :: Ptr Solver -> IO CInt
foreign import ccall "picosat_pop" picosat_pop :: Ptr Solver -> IO CInt

picosat_add_clause :: Ptr Solver -> [CInt] -> IO ()
picosat_add_clause solver clause = do
  mapM_ (picosat_add solver) clause
  picosat_add solver 0
  return ()
