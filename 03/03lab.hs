import Data.List
import Text.Regex
import System.Random
import Data.Ord

-- Point stores 2 floats
type Point = (Float, Float)
-- 3 int values for RGB
type Color = (Int, Int, Int)
-- list of points
type Polygon = [Point]
-- list of ints
type Person = [Int]
-- list of points and person objects
type Placement = [(Point, Person)]

-- defining types of funtions, their params and their return values
-- a = abritrary
type EnergyFunction a = a -> Int
type TempreatureFunction = Int -> Int -> Float
type TransitionProbabilityFunction = Int -> Int -> Float -> Float
type MotionFunction a = StdGen -> a -> (StdGen, a)

main = do
  -- reading in people.txt file
  people_text <- readFile "people.txt"
  -- declaring people list before passing in people.txt
  let people :: [Person]
      people = read people_text

  putStr "Number of people coming: "
  print (length people)

  let writePoint :: Point -> String
      writePoint (x,y) = (show x) ++ "," ++ (show y) ++ " "

  let writePolygon :: (Color, Polygon) -> String
      writePolygon((r,g,b), p) = "<polygon points=\"" ++ (concatMap writePoint p) ++ "\" style=\"fill:#cccccc;stroke:rgb("++(show r)++","++(show g)++","++(show b)++");stroke-width:2\"/>"

  let writePolygons :: [(Color, Polygon)] -> String
      writePolygons p = "<svg xmlns=\"http://www.w3.org/2000/svg\">"++(concatMap writePolygon p)++"</svg>"

  let colorize :: Color -> [Polygon] -> [(Color, Polygon)]
      colorize = zip.repeat

  let rainbow@[red,green,blue,yellow,purple,teal] = map colorize [(255,0,0),(0,255,0),(0,0,255),(255,255,0),(255,0,255),(0,255,255)]
  writeFile "tut0.svg" $ writePolygons (blue [[(100,100),(200,100),(200,200),(100,200)],[(200,200),(300,200),(300,300),(200,300)]])

  let readPoint :: String -> Point
      readPoint s | Just [x,y] <- matchRegex (mkRegex "([0-9.]+),([0-9.]+)") s = (read x,read y)

  let readPolygon :: String -> Polygon
      readPolygon = (map readPoint).(splitRegex $ mkRegex " L ")

  let readPolygons :: String -> [Polygon]
      readPolygons = (map readPolygon).tail.(splitRegex $ mkRegex "<path")

  park_data <- readFile "park.svg"

  let park = readPolygons park_data

  writeFile "tut1.svg" $ writePolygons (green park)
