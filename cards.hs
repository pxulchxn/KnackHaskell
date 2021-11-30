module Cards where
import Types
import System.Random
import Data.Array.IO
import Control.Monad
import System.IO.Unsafe


getCards::Int -> [Karte]
getCards n = shuffleCards generateCards n

cardsToString::[Karte] -> String
cardsToString (x:xs) = "[" ++ karteToString x ++ getCardsStringHelp xs ++ "]"

getCardsStringHelp:: [Karte] -> String
getCardsStringHelp [] = ""
getCardsStringHelp (x:xs) = ", " ++ karteToString x ++ getCardsStringHelp xs

getPlayerCards::[Karte] -> [Karte]
getPlayerCards cards = take 3 cards

getKICards::[Karte] -> [Karte]
getKICards cards = drop 3 (take 6 cards)

getTableCards::[Karte] -> [Karte]
getTableCards cards = drop 6 (take 9 cards)

getHandsHighestValue::[Karte] -> Int
getHandsHighestValue list = maximum (getHandsValueHelp list 0)

getHandsValueHelp::[Karte] -> Int -> [Int]
getHandsValueHelp list n = getHandTypValue list (getNextTyp n):
                            if (n+1) < length (enumFrom KARO) then
                                 getHandsValueHelp list (n+1)
                            else
                                [getSameCardNameValue list]

getHandTypValue::[Karte] -> Typ -> Int
getHandTypValue list mainTyp = getCardValues (getSameCardTypes list mainTyp)

hasPlayerWin::[Karte] -> Bool
hasPlayerWin list = hasWin (getPlayerCards list)

hasKIWin::[Karte] -> Bool
hasKIWin list = hasWin (getKICards list)

hasWin::[Karte] -> Bool
hasWin list = getHandsHighestValue list > 31

haveNewCardsToTable::[Karte] -> Bool
haveNewCardsToTable cards = isSIEBENInCards tableCards && isACHTInCards tableCards && isNEUNInCards tableCards
    where tableCards = getTableCards cards

isSIEBENInCards::[Karte] -> Bool
isSIEBENInCards list = isNameinCards list SIEBEN

isACHTInCards::[Karte] -> Bool
isACHTInCards list = isNameinCards list ACHT 

isNEUNInCards::[Karte] -> Bool
isNEUNInCards list = isNameinCards list NEUN

isNameinCards::[Karte] -> Name -> Bool
isNameinCards [] _ = False
isNameinCards (x:xs) name = (if sameName x name then True else False) || isNameinCards xs name

getCardValues::[Karte] -> Int
getCardValues [] = 0
getCardValues (x:xs) = kartenWert x + getCardValues xs

getSameCardNameValue::[Karte] -> Int
getSameCardNameValue (x:xs) =   if length (getSameCardNames (x:xs) (getName x)) == 3 then
                                    if (getName x) == ASS then
                                        41
                                    else
                                        31
                                else
                                    0

getSameCardTypes::[Karte] -> Typ -> [Karte]
getSameCardTypes [] _ = []
getSameCardTypes list mainTyp = [x | x <- list, sameTyp x mainTyp]

getSameCardNames::[Karte] -> Name -> [Karte]
getSameCardNames [] _ = []
getSameCardNames list mainName = [x | x <- list, sameName x mainName]

getNextTyp::Int -> Typ
getNextTyp n = (enumFrom KARO)!!n

generateCards::[Karte]
generateCards = [Karte(x,y) | x <- enumFrom KARO, y <- enumFrom SIEBEN]

swapPlayerWithTableCard::[Karte] -> Int -> Int -> [Karte]
swapPlayerWithTableCard list i j = swapCards list (i-1) (j+5)

swapAllPlayerWithTableCards::[Karte] -> [Karte]
swapAllPlayerWithTableCards list = swapPlayerWithTableCard (swapPlayerWithTableCard (swapPlayerWithTableCard list 1 1) 2 2) 3 3

swapCards::[Karte] -> Int -> Int -> [Karte]
swapCards list i j = swapCardsHelp list i j (list!!i) (list!!j)

swapCardsHelp::[Karte] -> Int -> Int -> Karte -> Karte -> [Karte]
swapCardsHelp (x:xs) i j f g
    | i == 0 = g : (swapCardsHelp xs (i-1) (j-1) f g)
    | j == 0 = f : (swapCardsHelp xs (i-1) (j-1) f g)
    | otherwise = x: (swapCardsHelp xs (i-1) (j-1) f g)

shuffleTableCards::[Karte] -> Int -> [Karte]
shuffleTableCards cards n = (take 6 cards) ++ shuffleCards (drop 6 cards) n

shuffleCards::[Karte] -> Int -> [Karte]
shuffleCards list n = shuffleCardsHelp list n

shuffleCardsHelp::[Karte] -> Int -> [Karte]
shuffleCardsHelp [] _ = []
shuffleCardsHelp list n = list!!n: shuffleCardsHelp newList newN
    where
        newList = removeElementFromList list n
        newN = randomNumber ((length newList)-1)

removeElementFromList::[Karte] -> Int -> [Karte]
removeElementFromList [] _ = []
removeElementFromList list (-1) = list
removeElementFromList (x:xs) n
    | n == 0 = removeElementFromList xs (n-1)
    | otherwise = x: removeElementFromList xs (n-1)

randomNumber :: Int -> Int
randomNumber a = unsafePerformIO (getStdRandom (randomR (0, a)))