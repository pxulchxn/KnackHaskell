module Player where
import Types
import Cards

-- generate the player lists
generatePlayerList::Int -> [Spieler]
generatePlayerList n = generatePlayerListHelp n 1

-- returns all players in list
generatePlayerListHelp::Int -> Int -> [Spieler]
generatePlayerListHelp n i
    | i == n = [Spieler {pId=(i-1), pName="Spieler " ++ (show i), hasCheck=False, hasClosed=False}]
    | otherwise = Spieler {pId=(i-1), pName="Spieler " ++ (show i), hasCheck=False, hasClosed=False}: generatePlayerListHelp n (i+1)

-- returns the player at the given position from a list
getPlayerFromList::[Spieler] -> Int -> Spieler
getPlayerFromList list n = list!!n

-- returns name of player
getPlayerName::Spieler -> String
getPlayerName Spieler{pName=pname} = pname

-- set name of player
setPlayerName::Spieler -> String -> Spieler
setPlayerName Spieler{pId=pid, pName=_, hasCheck=check, hasClosed=closed} pname = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=closed}

-- set player in the list
setPlayerInList::[Spieler] -> Spieler -> Int -> [Spieler]
setPlayerInList [] _ _ = []
setPlayerInList (x:xs) spieler i
    | i == 0 = spieler: setPlayerInList xs spieler (i-1)
    | otherwise = x: setPlayerInList xs spieler (i-1)

-- returns true when the player has already checked
hasPlayerAlreadyChecked::Spieler -> Bool
hasPlayerAlreadyChecked Spieler{hasCheck=check, hasClosed=closed} = check || closed

-- returns true when the player has already closed
hasPlayerAlreadyClosed::Spieler -> Bool
hasPlayerAlreadyClosed Spieler{hasClosed=closed} = closed

-- returns true when every player has checked or closed
hasEveryPlayerChecked::[Spieler] -> Bool
hasEveryPlayerChecked [] = True
hasEveryPlayerChecked (x:xs) = hasPlayerAlreadyChecked x && hasEveryPlayerChecked xs

-- set the boolean of a player check
setPlayerCheck:: Spieler -> Bool -> Spieler
setPlayerCheck Spieler{pId=pid, pName=pname, hasCheck=_, hasClosed=closed} check = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=closed}

-- set player closed
setPlayerClosed::Spieler -> Spieler
setPlayerClosed Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=_} = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=True}

-- rank players of their card amount
rankPlayers::[Karte] -> [Spieler] -> [(Spieler, Int)]
rankPlayers cards players = quicksort rankedList
    where rankedList = setPlayerCardsValue cards players 0

-- returns the player ranks as string
rankPlayersToString::(Spieler, Int) -> String 
rankPlayersToString (player, value) = (getPlayerName player) ++ " hat " ++ show value ++ " Punkte"

-- returns player in rank list
getRankPlayerFromList::[(Spieler, Int)] -> Int -> (Spieler, Int)
getRankPlayerFromList list n = list!!n

-- quicksort to sort rank player list
quicksort::[(Spieler, Int)] -> [(Spieler, Int)]
quicksort [] = []
quicksort (x:xs) = quicksort larger ++ [x] ++ quicksort smaller
    where
        smaller = [a | a <- xs, isLower a x]
        larger = [b | b <- xs, isHigher b x]

-- return true when player a has a lower or same hand value
isLower::(Spieler, Int) -> (Spieler, Int) -> Bool
isLower (_, a) (_, b) = a <= b

-- return true when player a has a higher hand value
isHigher::(Spieler, Int) -> (Spieler, Int) -> Bool
isHigher (_, a) (_, b) = a > b

-- return the id of the current player
playerAmZug::Int -> [Spieler] -> Int
playerAmZug zug players = mod (zug) (length players)

-- return true when round one is done
isRoundOneFinish::Int -> [Spieler] -> Bool
isRoundOneFinish zug players = zug >= (length players)