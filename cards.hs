module Cards where
import Types
import System.Random
import System.IO.Unsafe


getCards::[(Typ, Name)]
getCards = shuffleCards generateCards

getPlayerCards::[(Typ, Name)]
getPlayerCards = take 3 getCards

getKICards::[(Typ, Name)]
getKICards = drop 3 (take 6 getCards)

getTableCards::[(Typ, Name)]
getTableCards = drop 6 (take 9 getCards)

getHandsHighestValue::[(Typ, Name)] -> Int
getHandsHighestValue list = maximum (getHandsValueHelp list 0)

getHandsValueHelp::[(Typ, Name)] -> Int -> [Int]
getHandsValueHelp list n = getHandTypValue list (getNextTyp n):
                            if (n+1) < length (enumFrom KARO) then
                                 getHandsValueHelp list (n+1)
                            else
                                [getSameCardNameValue list]

getHandTypValue::[(Typ, Name)] -> Typ -> Int
getHandTypValue list mainTyp = getCardValues (getSameCardTypes list mainTyp)

haveNewCardsToTable::Bool
haveNewCardsToTable = isSIEBENInCards cards && isACHTInCards cards && isNEUNInCards cards
    where cards = getTableCards

isSIEBENInCards::[(Typ, Name)] -> Bool
isSIEBENInCards list = isNameinCards list SIEBEN

isACHTInCards::[(Typ, Name)] -> Bool
isACHTInCards list = isNameinCards list ACHT 

isNEUNInCards::[(Typ, Name)] -> Bool
isNEUNInCards list = isNameinCards list NEUN

isNameinCards::[(Typ, Name)] -> Name -> Bool
isNameinCards [] _ = False
isNameinCards (x:xs) name = (if sameName x name then True else False) || isNameinCards xs name

getCardValues::[(Typ, Name)] -> Int
getCardValues [] = 0
getCardValues (x:xs) = kartenWert x + getCardValues xs

getSameCardNameValue::[(Typ, Name)] -> Int
getSameCardNameValue (x:xs) =   if length (getSameCardNames (x:xs) (getName x)) == 3 then
                                    if (getName x) == ASS then
                                        41
                                    else
                                        31
                                else
                                    0

getSameCardTypes::[(Typ, Name)] -> Typ -> [(Typ, Name)]
getSameCardTypes [] _ = []
getSameCardTypes list mainTyp = [x | x <- list, sameTyp x mainTyp]

getSameCardNames::[(Typ, Name)] -> Name -> [(Typ, Name)]
getSameCardNames [] _ = []
getSameCardNames list mainName = [x | x <- list, sameName x mainName]

getNextTyp::Int -> Typ
getNextTyp n = (enumFrom KARO)!!n

generateCards::[(Typ, Name)]
generateCards = [(x,y) | x <- enumFrom KARO, y <- enumFrom SIEBEN]

shuffleTableCards::[(Typ, Name)]
shuffleTableCards = (take 6 getCards) ++ shuffleCards (drop 6 getCards)

shuffleCards::[(Typ, Name)] -> [(Typ, Name)]
shuffleCards list = shuffleCardsHelp list (randomNumber (length list-1))

shuffleCardsHelp::[(Typ, Name)] -> Int -> [(Typ, Name)]
shuffleCardsHelp [] _ = []
shuffleCardsHelp list n = list!!n: shuffleCardsHelp newList newN
    where
        newList = removeElementFromList list n
        newN = randomNumber ((length newList)-1)

removeElementFromList::[(Typ, Name)] -> Int -> [(Typ, Name)]
removeElementFromList [] _ = []
removeElementFromList list (-1) = list
removeElementFromList (x:xs) n
    | n == 0 = removeElementFromList xs (n-1)
    | otherwise = x: removeElementFromList xs (n-1)

randomNumber :: Int -> Int
randomNumber a = unsafePerformIO (getStdRandom (randomR (0, a)))