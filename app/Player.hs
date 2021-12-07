module Player where
import Types
import Cards

generatePlayerList::Int -> [Spieler]
generatePlayerList n = generatePlayerListHelp n 1

generatePlayerListHelp::Int -> Int -> [Spieler]
generatePlayerListHelp n i
    | i == n = [Spieler {pId=(i-1), pName="Spieler " ++ (show i), hasCheck=False, hasClosed=False}]
    | otherwise = Spieler {pId=(i-1), pName="Spieler " ++ (show i), hasCheck=False, hasClosed=False}: generatePlayerListHelp n (i+1)

getPlayerFromList::[Spieler] -> Int -> Spieler
getPlayerFromList list n = list!!n

getPlayerName::Spieler -> String
getPlayerName Spieler{pName=pname} = pname

setPlayerName::Spieler -> String -> Spieler
setPlayerName Spieler{pId=pid, pName=_, hasCheck=check, hasClosed=closed} pname = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=closed}

setPlayerInList::[Spieler] -> Spieler -> Int -> [Spieler]
setPlayerInList [] _ _ = []
setPlayerInList (x:xs) spieler i
    | i == 0 = spieler: setPlayerInList xs spieler (i-1)
    | otherwise = x: setPlayerInList xs spieler (i-1)

hasPlayerAlreadyChecked::Spieler -> Bool
hasPlayerAlreadyChecked Spieler{hasCheck=check} = check

hasPlayerAlreadyClosed::Spieler -> Bool
hasPlayerAlreadyClosed Spieler{hasClosed=closed} = closed

hasEveryPlayerChecked::[Spieler] -> Bool
hasEveryPlayerChecked [] = True
hasEveryPlayerChecked (x:xs) = hasPlayerAlreadyChecked x && hasEveryPlayerChecked xs

setPlayerCheck:: Spieler -> Bool -> Spieler
setPlayerCheck Spieler{pId=pid, pName=pname, hasCheck=_, hasClosed=closed} check = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=closed}

setPlayerClosed::Spieler -> Spieler
setPlayerClosed Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=_} = Spieler{pId=pid, pName=pname, hasCheck=check, hasClosed=True}

rankPlayers::[Karte] -> [Spieler] -> [(Spieler, Int)]
rankPlayers cards players = quicksort rankedList
    where rankedList = setPlayerCardsValue cards players 0

rankPlayersToString::(Spieler, Int) -> String 
rankPlayersToString (player, value) = (getPlayerName player) ++ " hat " ++ show value ++ " Punkte"

getRankPlayerFromList::[(Spieler, Int)] -> Int -> (Spieler, Int)
getRankPlayerFromList list n = list!!n

quicksort::[(Spieler, Int)] -> [(Spieler, Int)]
quicksort [] = []
quicksort (x:xs) = quicksort larger ++ [x] ++ quicksort smaller
    where
        smaller = [a | a <- xs, isLower a x]
        larger = [b | b <- xs, isHigher b x]

isLower::(Spieler, Int) -> (Spieler, Int) -> Bool
isLower (_, a) (_, b) = a <= b

isHigher::(Spieler, Int) -> (Spieler, Int) -> Bool
isHigher (_, a) (_, b) = a > b