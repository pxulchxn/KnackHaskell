module Types where

--TODO: Enum für den Kartentypen sinnvoll? Wenn ja, dann nachschauen, ob Enum richtig erstellt wurde
data Typ = KARO | HERZ | PIK | KREUZ deriving (Enum, Show, Eq)
data Name = SIEBEN | ACHT | NEUN | ZEHN | BUBE | DAME | KOENIG | ASS deriving(Enum, Show, Eq)

data Karte = Karte(Typ, Name) deriving (Eq, Show)

data Spieler = Spieler {    --neuer Datentyp namens Spieler
    pId::Int,              -- wichtig für Auslegen bei den Runden
    pName::String,          -- Name des Spielers
    hasCheck::Bool,
    hasClosed::Bool
} deriving (Show, Eq)

-- return a string of a card
karteToString::Karte -> String
karteToString (Karte(typ, name)) = "" ++ show typ ++ " " ++ show name

-- return the value of the card
kartenWert::Karte -> Int
kartenWert (Karte(_, a))
    | a == SIEBEN = 7
    | a == ACHT = 8
    | a == NEUN = 9
    | a == ASS = 12
    | otherwise = 10


-- return the card name
getName::Karte -> Name
getName (Karte(_, name)) = name


-- return the card type
getTyp::Karte -> Typ
getTyp (Karte(typ, _)) = typ


-- return true when the card type and the given typ are equal
sameTyp::Karte -> Typ -> Bool
sameTyp (Karte(typ, _)) mainTyp = typ == mainTyp

-- return true when the card name and the given name are equal
sameName::Karte -> Name -> Bool
sameName (Karte(_, name)) mainName = name == mainName