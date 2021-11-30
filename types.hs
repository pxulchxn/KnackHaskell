module Types where

--TODO: Enum für den Kartentypen sinnvoll? Wenn ja, dann nachschauen, ob Enum richtig erstellt wurde
data Typ = KARO | HERZ | PIK | KREUZ deriving (Enum, Show, Eq)
data Name = SIEBEN | ACHT | NEUN | ZEHN | BUBE | DAME | KOENIG | ASS deriving(Enum, Show, Eq)

data Karte = Karte(Typ, Name) deriving (Eq, Show)

data Spieler = Spieler {    --neuer Datentyp namens Spieler
    id :: Int,              -- wichtig für Auslegen bei den Runden
    pName :: String          -- Name des Spielers
}

karteToString::Karte -> String
karteToString (Karte(typ, name)) = "" ++ show typ ++ " " ++ show name

kartenWert::Karte -> Int
kartenWert (Karte(_, a))
    | a == SIEBEN = 7
    | a == ACHT = 8
    | a == NEUN = 9
    | a == ASS = 12
    | otherwise = 10

getName::Karte -> Name
getName (Karte(_, name)) = name

getTyp::Karte -> Typ
getTyp (Karte(typ, _)) = typ

sameTyp::Karte -> Typ -> Bool
sameTyp (Karte(typ, _)) mainTyp = typ == mainTyp

sameName::Karte -> Name -> Bool
sameName (Karte(_, name)) mainName = name == mainName