import Data.IORef
import System.Random
import Control.Monad
import Types
import Cards
import Player


-- main method runs all the time until the end
main = do
    ioChoosePlayers
    

ioChoosePlayers = do
    putStrLn "Wie viele Spieler nehmen teil? (2-4)"
    i <- readLn :: IO Int
    if (i >= 2 && i <= 4) then do
        players <- newIORef (generatePlayerList i)
        ioChoosePlayerNames players 0
    else do
        putStrLn "Wrong Input!"
        ioChoosePlayers

ioChoosePlayerNames players n = do
    playersTmp <- readIORef players
    if (n < (length playersTmp)) then do
        let player = getPlayerFromList playersTmp n
        putStrLn ("Wie soll " ++ (getPlayerName player ) ++ " heißen?")
        name <- getLine
        let newPlayer = setPlayerName player name
        writeIORef players (setPlayerInList playersTmp newPlayer n)
        ioChoosePlayerNames players (n+1)
    else do
        print playersTmp
        ioGenerateCards players

ioGenerateCards players = do
    let x = generateCards
    let rndNumber = randomNumber (length x-1)
    let tmpCards = shuffleCards x rndNumber

    cards <- newIORef tmpCards

    ioKnack cards players 0

-- checks whether the player has won and then says that the game is over or the game continues and waits for player input
ioKnack cards players amZug = do
    cardsTmp <- readIORef cards
    playersTmp <- readIORef players

    let name = getPlayerName (getPlayerFromList playersTmp amZug)

    print (shuffleTableCards cardsTmp (randomNumber (length cardsTmp-1)) (length playersTmp))

    when (haveNewCardsToTable cardsTmp (length playersTmp)) $ writeIORef cards (shuffleTableCards cardsTmp (randomNumber (length cardsTmp-1)) (length playersTmp))

    if (hasPlayerWin cardsTmp amZug) then do
        
        putStrLn (name ++ " hat gewonnen!")
        putStrLn (cardsToString (getPlayerCards cardsTmp amZug))
    else do
        cardsTmp <- readIORef cards
        putStrLn (name ++ " ist am Zug!")
        putStrLn ("Table Cards: " ++ cardsToString (getTableCards cardsTmp (length playersTmp)))
        putStrLn ("Player Cards: " ++ cardsToString (getPlayerCards cardsTmp amZug))

        ioSpielzug cards players amZug
    
-- the player can decide whether he wants to swap cards or end the game (the game status is still saved)
ioSpielzug cards players amZug = do
    putStrLn "Commands: swap, check, exit"
    aktion <- getLine
    cardsTmp <- readIORef cards

    case () of
       _ | aktion == "swap" -> ioSwap cards players amZug
         | aktion == "check" -> ioCheck cards players amZug
         | aktion == "exit" -> putStrLn "Good Bye!"
         | otherwise -> do putStrLn "Wrong Input"
                           ioSpielzug cards players amZug

-- gives the player the choice of how many cards to swap
ioSwap cards players amZug = do
    putStrLn "(A)ll or (O)ne?"
    aktion <- getLine
    
    case () of
      _ | aktion == "A" || aktion == "a" -> ioSwapAllCards cards players amZug
        | aktion == "O" || aktion == "o" -> ioSwapOneCard cards players amZug
        | otherwise -> do putStrLn "Wrong Input!"
                          ioSwap cards players amZug

-- exchanges all cards of the player on his / her console input 
ioSwapAllCards cards players amZug = do
    cardsTmp <- readIORef cards
    playersTmp <- readIORef players
    writeIORef cards (swapAllPlayerWithTableCards cardsTmp amZug (length playersTmp))

    let player = getPlayerFromList playersTmp amZug
    when (hasPlayerAlreadyChecked player) $ do 
        let newPlayer = setPlayerCheck player False
        writeIORef players (setPlayerInList playersTmp newPlayer amZug)

    finishZug cards players amZug

-- exchanges the player's cards on his / her console input
ioSwapOneCard cards players amZug = do
    cardsTmp <- readIORef cards
    playersTmp <- readIORef players
    putStrLn "Player Cards (1-3)"
    i <- readLn :: IO Int
    if i >= 1 && i <= 3 then do
        putStrLn "Table Cards (1-3)"
        j <- readLn :: IO Int
        if j >= 1 && j <= 3 then do
            writeIORef cards (swapPlayerWithTableCard cardsTmp i j amZug (length playersTmp))

            let player = getPlayerFromList playersTmp amZug
            when (hasPlayerAlreadyChecked player) $ do 
                let newPlayer = setPlayerCheck player False
                writeIORef players (setPlayerInList playersTmp newPlayer amZug)

            finishZug cards players amZug
        else do
            putStrLn "Wrong Input!"
            ioSwapOneCard cards players amZug
    else do
        putStrLn "Wrong Input!"
        ioSwapOneCard cards players amZug

ioCheck cards players amZug = do
    playersTmp <- readIORef players
    let player = getPlayerFromList playersTmp amZug

    if(hasPlayerAlreadyChecked player) then do
        putStrLn "You can't check again. Choose another option!"
        ioKnack cards players amZug
    else do
        let newPlayer = setPlayerCheck player True
        writeIORef players (setPlayerInList playersTmp newPlayer amZug)
        finishZug cards players amZug

finishZug cards players amZug = do
    cardsTmp <- readIORef cards
    playersTmp <- readIORef players
    

    if (hasPlayerWin cardsTmp amZug) then do
        let name = getPlayerName (getPlayerFromList playersTmp amZug)
        putStrLn (name ++ " hat gewonnen!")
        putStrLn (cardsToString (getPlayerCards cardsTmp amZug))
    else do
        when (hasEveryPlayerChecked playersTmp) $ writeIORef cards (shuffleTableCards cardsTmp (randomNumber (length cardsTmp-1)) (length playersTmp))

        cardsTmp <- readIORef cards

        ioKnack cards players (mod (amZug+1) (length playersTmp))