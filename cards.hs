module Cards where
import Types
import System.Random
import Data.Array.IO
import Control.Monad
import System.IO.Unsafe


getCards::[Karte]
getCards = shuffleCards generateCards

getCardsString::String
getCardsString = cardsToString getCards

cardsToString::[Karte] -> String
cardsToString list = "[" ++ getCardsStringHelp list ++ "]"

getCardsStringHelp:: [Karte] -> String
getCardsStringHelp [] = ""
getCardsStringHelp (x:xs) = karteToString x ++ ", " ++ getCardsStringHelp xs

getPlayerCards::[Karte]
getPlayerCards = take 3 getCards

getKICards::[Karte]
getKICards = drop 3 (take 6 getCards)

getTableCards::[Karte]
getTableCards = drop 6 (take 9 getCards)

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

haveNewCardsToTable::Bool
haveNewCardsToTable = isSIEBENInCards cards && isACHTInCards cards && isNEUNInCards cards
    where cards = getTableCards

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

shuffleTableCards::[Karte]
shuffleTableCards = (take 6 getCards) ++ shuffleCards (drop 6 getCards)

shuffleCards::[Karte] -> [Karte]
shuffleCards list = shuffleCardsHelp list (randomNumber (length list-1))

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