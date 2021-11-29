import Data.IORef
import System.Random

import Types
import Cards

main = do
    varA <- newIORef getCards
    knack varA

knack varA = do
    a0 <- readIORef varA
    print a0
    spielzug varA
    

spielzug varA = do
    aktion <- getLine

    if aktion == "shuffle" then
        writeIORef varA shuffleTableCards
    else
        putStrLn "Nothing Done"

    if aktion == "exit" then
        putStrLn "Good Bye!"
    else
        knack varA
