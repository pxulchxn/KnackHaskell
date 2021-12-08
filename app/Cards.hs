module Cards where
import Types
import System.Random
import Data.Array.IO
import Control.Monad
import System.IO.Unsafe


-- returns all cards
getCards::Int -> [Karte]
getCards n = shuffleCards generateCards n

-- returns all cards as a string
cardsToString::[Karte] -> String
cardsToString (x:xs) = "[" ++ karteToString x ++ getCardsStringHelp xs ++ "]"

-- returns cards as a string
getCardsStringHelp:: [Karte] -> String
getCardsStringHelp [] = ""
getCardsStringHelp (x:xs) = ", " ++ karteToString x ++ getCardsStringHelp xs

-- returns the player's cards
getPlayerCards::[Karte] -> Int -> [Karte]
getPlayerCards cards n = drop (3*n) (take (3*(n+1)) cards)

-- returns the cards from the middle
getTableCards::[Karte] -> Int -> [Karte]
getTableCards cards n = drop (3*n) (take (3*(n+1)) cards)

-- returns the highest aggregate value of all types
getHandsHighestValue::[Karte] -> Int
getHandsHighestValue list = maximum (getHandsValueHelp list 0)

-- returns a list with all the aggregated values ​​of the types
getHandsValueHelp::[Karte] -> Int -> [Int]
getHandsValueHelp list n = getHandTypValue list (getNextTyp n):
                            if (n+1) < length (enumFrom KARO) then
                                 getHandsValueHelp list (n+1)
                            else
                                [getSameCardNameValue list]

-- returns the highest aggregate value of a type
getHandTypValue::[Karte] -> Typ -> Int
getHandTypValue list mainTyp = getCardValues (getSameCardTypes list mainTyp)

-- returns the truth value of whether the player has won
hasPlayerWin::[Karte] -> Int -> Bool
hasPlayerWin list n = hasWin (getPlayerCards list n)

-- returns the truth value of whether someone has won
hasWin::[Karte] -> Bool
hasWin list = getHandsHighestValue list > 31

setPlayerCardsValue::[Karte] -> [Spieler] -> Int -> [(Spieler, Int)]
setPlayerCardsValue _ [] _ = []
setPlayerCardsValue cards (x:xs) n = (x, getHandsHighestValue (getPlayerCards cards n)): setPlayerCardsValue cards xs (n+1)

-- returns the truth value of whether new cards have to be placed in the middle
haveNewCardsToTable::[Karte] -> Int -> Bool
haveNewCardsToTable cards n = isSIEBENInCards tableCards && isACHTInCards tableCards && isNEUNInCards tableCards
    where tableCards = getTableCards cards n

-- returns the truth value of whether there is a seven in the cards
isSIEBENInCards::[Karte] -> Bool
isSIEBENInCards list = isNameinCards list SIEBEN

-- returns the truth value of whether there is a eight in the cards
isACHTInCards::[Karte] -> Bool
isACHTInCards list = isNameinCards list ACHT 

-- returns the truth value of whether there is a nine in the cards
isNEUNInCards::[Karte] -> Bool
isNEUNInCards list = isNameinCards list NEUN

-- returns the truth value of whether a Name is in the cards
isNameinCards::[Karte] -> Name -> Bool
isNameinCards [] _ = False
isNameinCards (x:xs) name = (if sameName x name then True else False) || isNameinCards xs name

-- returns the value of the card
getCardValues::[Karte] -> Int
getCardValues [] = 0
getCardValues (x:xs) = kartenWert x + getCardValues xs

-- returns the aggregated value for the same Name
getSameCardNameValue::[Karte] -> Int
getSameCardNameValue (x:xs) =   if length (getSameCardNames (x:xs) (getName x)) == 3 then
                                    if (getName x) == ASS then
                                        41
                                    else
                                        31
                                else
                                    0

-- returns a list with all of the same Typ
getSameCardTypes::[Karte] -> Typ -> [Karte]
getSameCardTypes [] _ = []
getSameCardTypes list mainTyp = [x | x <- list, sameTyp x mainTyp]

-- returns a list with all of the same Name
getSameCardNames::[Karte] -> Name -> [Karte]
getSameCardNames [] _ = []
getSameCardNames list mainName = [x | x <- list, sameName x mainName]

-- returns the Typ
getNextTyp::Int -> Typ
getNextTyp n = (enumFrom KARO)!!n

-- creates the list with all cards
generateCards::[Karte]
generateCards = [Karte(x,y) | x <- enumFrom KARO, y <- enumFrom SIEBEN]

-- exchanges a card between the player and the middle and gives it back
swapPlayerWithTableCard::[Karte] -> Int -> Int -> Int -> Int -> [Karte]
swapPlayerWithTableCard list i j currentPlayer maxAnzahl = swapCards list (i-1+currentPlayer*3) (j+maxAnzahl*3-1)

-- exchanges all cards of the player with the middle and gives them back
swapAllPlayerWithTableCards::[Karte] -> Int -> Int -> [Karte]
swapAllPlayerWithTableCards list currentPlayer maxAnzahl = swapPlayerWithTableCard (swapPlayerWithTableCard (swapPlayerWithTableCard list 1 1 currentPlayer maxAnzahl) 2 2 currentPlayer maxAnzahl) 3 3 currentPlayer maxAnzahl

-- returns a list of the cards that the player has exchanged
swapCards::[Karte] -> Int -> Int -> [Karte]
swapCards list i j = swapCardsHelp list i j (list!!i) (list!!j) -- wofür steht list!!i und list!!j? 

-- swap two cards in array
swapCardsHelp::[Karte] -> Int -> Int -> Karte -> Karte -> [Karte]
swapCardsHelp [] _ _ _ _ = []
swapCardsHelp (x:xs) i j f g
    | i == 0 = g : (swapCardsHelp xs (i-1) (j-1) f g)
    | j == 0 = f : (swapCardsHelp xs (i-1) (j-1) f g)
    | otherwise = x: (swapCardsHelp xs (i-1) (j-1) f g)

-- returns a randomly shuffled list of the cards in the middle
shuffleTableCards::[Karte] -> Int -> Int -> [Karte]
shuffleTableCards cards n i = (take (3*i) cards) ++ (shuffleCards (drop (3*i) cards) (mod n ((length cards)-3*i)))

-- returns a randomly shuffled list
shuffleCards::[Karte] -> Int -> [Karte]
shuffleCards list n = shuffleCardsHelp list n

-- returns a randomly shuffled list
shuffleCardsHelp::[Karte] -> Int -> [Karte]
shuffleCardsHelp [] _ = []
shuffleCardsHelp list n = list!!n: shuffleCardsHelp newList newN
    where
        newList = removeElementFromList list n
        newN = randomNumber ((length newList)-1)

-- returns a list without a specific element
removeElementFromList::[Karte] -> Int -> [Karte]
removeElementFromList [] _ = []
removeElementFromList list (-1) = list
removeElementFromList (x:xs) n
    | n == 0 = removeElementFromList xs (n-1)
    | otherwise = x: removeElementFromList xs (n-1)

-- returns a random number from 0 to input
randomNumber :: Int -> Int
randomNumber a = unsafePerformIO (getStdRandom (randomR (0, a)))