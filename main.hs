data Art = KARO | HERZ | PIK | KREUZ deriving (Enum, Show)

data Karte = Karte {
    name :: String,
    art :: Art,
    wert :: Int
}

data Article = Article {name1::String, price::Int} deriving (Show, Read, Eq, Ord)

hose :: Article
hose = Article "Hose" 50

hose3 :: Article
hose3 = Article "Hose" 52

hose4 :: Article
hose4 = Article "Hose" 50

newtype StrWrapper = Wrap String

v :: StrWrapper
v = Wrap "Hallo Welt"

