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
  putStr "Hello World"
  -- reading in people.txt file
  people_text <- readFile "people.txt"
  -- declaring people list before passing in people.txt
  let people :: [Person]
    people = read people_text

  putStr "Number of people coming: "
  print (length people)
