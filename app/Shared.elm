module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html, text)
import Html.Attributes exposing (href, style)
import Html.Events
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type Msg
    = SharedMsg SharedMsg
    | MenuClicked


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMenu : Bool
    }


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMenu = False }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )

        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ Html.nav
            [ style "display" "flex"
            , style "justify-content" "space-between"
            , style "align-items" "center"
            , style "padding" "10px 0px"
            , style "border-bottom" "1px solid var(--iris)"
            , style "max-width" "800px"
            , style "margin-left" "auto"
            , style "margin-right" "auto"
            , style "margin-bottom" "10px"
            ]
            [ Html.div
                []
                [ Html.h1
                    [ style "font-size" "2em"
                    , style "font-weight" "bold"
                    , style "margin" "0"
                    ]
                    [ text "Youwen Wu" ]
                ]
            , Html.ul
                [ style "list-style-type" "none" -- Remove default list bullets
                , style "margin" "0" -- Remove default margin
                , style "padding" "0" -- Remove default padding
                , style "display" "flex" -- Lay out links horizontally
                , style "font-size" "1.2rem"
                ]
                [ Html.li [ style "margin-left" "15px" ]
                    [ Html.a
                        [ href "/"
                        ]
                        [ text "Home" ]
                    ]
                , Html.li [ style "margin-left" "15px" ]
                    [ Html.a
                        [ href "/impressum"
                        ]
                        [ text "Impressum" ]
                    ]
                ]
            ]
            |> Html.map toMsg
        , Html.main_ [] pageView.body
        ]
    , title = pageView.title
    }
