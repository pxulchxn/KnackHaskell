--TODO: Enum für den Kartentypen sinnvoll? Wenn ja, dann nachschauen, ob Enum richtig erstellt wurde
data Art = KARO | HERZ | PIK | KREUZ deriving (Enum, Show) 

data Karte = Karte {        -- neuer Datentyp namens Karte
    name :: String,         -- Name der Karte
    art :: Art,             -- Art der Karte
    wert :: Int             -- Wertigkeit der Karte
}

data Spieler = Spieler {    --neuer Datentyp namens Spieler
    id :: Int,              -- wichtig für Auslegen bei den Runden
    name :: String          -- Name des Spielers
}  