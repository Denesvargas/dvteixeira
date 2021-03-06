import Data.Char

-- Converte um caracter em um inteiro
encodeChar :: Char -> Int
encodeChar c = ord c - ord 'a'

-- Converte um inteiro em um caracter
decodeChar :: Int -> Char
decodeChar n = chr (ord 'a' + n)

-- Calcula percentagem: n/m*100
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m)*100

-- Rotacao de uma lista para esquerda em n posicoes
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

-- Tabela de frequencias das letras 'a'..'z' (lingua portuguesa)
-- https://pt.wikipedia.org/wiki/Frequ%C3%AAncia_de_letras
table :: [Float]
table = [14.6, 1.0, 3.9, 5.0, 12.6, 1.0, 1.3, 1.3, 6.2, 0.4, 0.1, 2.8, 4.7, 
         5.0, 10.7, 2.5, 1.2, 6.5, 7.8, 4.3, 4.6, 1.7, 0.1, 0.2, 0.1, 0.5]

-- Distancia entre 2 listas de frequencia
chi2 :: [Float] -> [Float] -> Float
chi2 os es = sum [((o-e)^2)/e | (o,e) <- zip os es]

-- Use esta funcao para decodificar uma mensagem!
crack :: String -> String
crack cs = encodeStr cs (-factor)
           where factor = head (positions (minimum chitab) chitab)
                 chitab = [ chi2 (rotate n table' ) table | n <- [0..25] ]
                 table' = freqs cs

--- exercicio 1 -----------------------------------------------------------------------------------------------

shiftChar :: Char -> Int -> Char
shiftChar c x = decodeChar (mod ((encodeChar c) + x) 26)

--- exercicio 2

encodeStr :: String -> Int -> String
encodeStr str x = map (\n -> shiftChar n x) str

--- exercicio 3

countValids :: String -> Int
countValids str = length (filter isLower str)

--- exercicio 4

countChar :: Char -> String -> Int
countChar c str = length (filter (== c) str)

--- exercicio 5

freqs :: String -> [Float]
freqs str = [percent (countChar x str) (countValids str) | x <- ['a'..'z'] ]

--- exercicio 6

positions :: Float -> [Float] -> [Int]
positions x str = map snd $ filter (\n-> fst n == x) (zip str [0..])
