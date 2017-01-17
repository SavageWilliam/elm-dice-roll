
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
import String exposing (concat)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

--MODEL

type alias Model =
  { dieFace1 : Int
  , dieFace2 : Int
  }

--INIT

init: (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)

--UPDATE
type Msg = Roll | NewFace1 Int | NewFace2 Int

type alias Time =
    Float

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model,  Cmd.batch [ran NewFace1, ran NewFace2])

    NewFace1 newFace ->
      ({ model | dieFace1 = newFace}, Cmd.none)

    NewFace2 newFace ->
      ({ model | dieFace2 = newFace }, Cmd.none)


ran msg =
  Random.generate msg (Random.int 1 6)


--UTILITIES
dieImage : Int -> String
dieImage dieFace =
  concat ["./image-dieface/", (toString dieFace), ".svg"]

--VIEW
view : Model -> Html Msg
view model =
  div [style [("text-align" , "center"), ("margin-top", "30px")]]
    [ img [src (dieImage model.dieFace1), style [("display" , "inline-block" )]] []
    , img [src (dieImage model.dieFace2), style [("display" , "inline-block" )]] []
    , button [ onClick Roll, style buttonStyle ] [ text "Roll"]
    ]
    
buttonStyle : List (String, String)
buttonStyle =
  [("background-color", "#e4685d")
  ,("border-radius","9px")
  ,("border","1px solid #ffffff")
  ,("display" , "block")
  ,("margin", "0 auto")
  ,("cursor","pointer")
  ,("color","#ffffff")
  ,("font-family","Arial")
  ,("font-size","15px")
  ,("padding","12px 15px")
  ,("text-decoration","none")
  ,("text-shadow","0px 1px 0px #b23e35")
  ]


--subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
