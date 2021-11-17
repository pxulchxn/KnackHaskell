data Art = KARO | HERZ | PIK | KREUZ deriving (Enum, Show)

data Karte = Karte {
    name :: String,
    art :: Art,
    wert :: Int
}

