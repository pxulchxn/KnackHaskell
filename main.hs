import Data.IORef
import System.Random
import Control.Monad
import Types
import Cards


-- main method runs all the time until the end
main = do
    let x = generateCards
    let rndNumber = randomNumber (length x-1)
    let tmpCards = shuffleCards x rndNumber

    cards <- newIORef tmpCards

    knack cards

-- checks whether the player has won and then says that the game is over or the game continues and waits for player input
knack cards = do
    cardsTmp <- readIORef cards

    when (haveNewCardsToTable cardsTmp) $ writeIORef cards (shuffleTableCards cardsTmp (randomNumber (length cardsTmp-1)))

    if (hasPlayerWin cardsTmp) then do
        putStrLn "Der Spieler hat gewonnen!"
        putStrLn (cardsToString (getPlayerCards cardsTmp))
    else do
        cardsTmp <- readIORef cards
        putStrLn ("Table Cards: " ++ cardsToString (getTableCards cardsTmp))
        putStrLn ("Player Cards: " ++ cardsToString (getPlayerCards cardsTmp))

        spielzug cards
    
-- the player can decide whether he wants to swap cards or end the game (the game status is still saved)
spielzug cards = do
    putStrLn "Commands: swap, exit"
    aktion <- getLine
    cardsTmp <- readIORef cards

    case () of
       _ | aktion == "swap" -> swap cards
         | aktion == "exit" -> putStrLn "Good Bye!"
         | otherwise -> do putStrLn "Wrong Input"
                           spielzug cards

-- gives the player the choice of how many cards to swap
swap cards = do
    putStrLn "(A)ll or (O)ne?"
    aktion <- getLine
    
    case () of
      _ | aktion == "A" || aktion == "a" -> swapAllCards cards
        | aktion == "O" || aktion == "o" -> swapOneCard cards
        | otherwise -> do putStrLn "Wrong Input!"
                          swap cards

-- exchanges all cards of the player on his / her console input 
swapAllCards cards = do
    cardsTmp <- readIORef cards
    writeIORef cards (swapAllPlayerWithTableCards cardsTmp)
    knack cards

-- exchanges the player's cards on his / her console input
swapOneCard cards = do
    cardsTmp <- readIORef cards
    putStrLn "Player Cards (1-3)"
    i <- readLn :: IO Int
    if i >= 1 && i <= 3 then do
        putStrLn "Table Cards (1-3)"
        j <- readLn :: IO Int
        if j >= 1 && j <= 3 then do
            writeIORef cards (swapPlayerWithTableCard cardsTmp i j)
            knack cards
        else do
            putStrLn "Wrong Input!"
            swapOneCard cards
    else do
        putStrLn "Wrong Input!"
        swapOneCard cards