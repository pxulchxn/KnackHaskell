module Types where

--TODO: Enum für den Kartentypen sinnvoll? Wenn ja, dann nachschauen, ob Enum richtig erstellt wurde
data Typ = KARO | HERZ | PIK | KREUZ deriving (Enum, Show, Eq)
data Name = SIEBEN | ACHT | NEUN | ZEHN | BUBE | DAME | KOENIG | ASS deriving(Enum, Show, Eq)

data Karte = Karte {        -- neuer Datentyp namens Karte
    name :: Name,         -- Name der Karte
    art :: Typ,             -- Art der Karte
    wert :: Int             -- Wertigkeit der Karte
}

data Spieler = Spieler {    --neuer Datentyp namens Spieler
    id :: Int,              -- wichtig für Auslegen bei den Runden
    pName :: String          -- Name des Spielers
}

kartenWert::(Typ, Name) -> Int
kartenWert (_, a)
    | a == SIEBEN = 7
    | a == ACHT = 8
    | a == NEUN = 9
    | a == ASS = 11
    | otherwise = 10

getName::(Typ, Name) -> Name
getName (_, name) = name

getTyp::(Typ, Name) -> Typ
getTyp (typ, _) = typ

sameTyp::(Typ, Name) -> Typ -> Bool
sameTyp (typ, _) mainTyp = typ == mainTyp

sameName::(Typ, Name) -> Name -> Bool
sameName (_, name) mainName = name == mainName