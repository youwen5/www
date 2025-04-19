module Route.Impressum exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import Effect
import ErrorPage
import FatalError
import Head
import Html exposing (a, span, text)
import Html.Attributes exposing (href, style)
import PagesMsg
import RouteBuilder
import Server.Request
import Server.Response
import Shared
import UrlPath
import View


type alias Model =
    {}


type Msg
    = NoOp


type alias RouteParams =
    {}


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.serverRender
        { data = data
        , action = action
        , head = head
        }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect.Effect Msg )
init app shared =
    ( {}, Effect.none )


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect.Effect Msg )
update app shared msg model =
    case msg of
        NoOp ->
            ( model, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions routeParams path shared model =
    Sub.none


type alias Data =
    {}


type alias ActionData =
    {}


data :
    RouteParams
    -> Server.Request.Request
    -> BackendTask.BackendTask FatalError.FatalError (Server.Response.Response Data ErrorPage.ErrorPage)
data routeParams request =
    BackendTask.succeed (Server.Response.render {})


head : RouteBuilder.App Data ActionData RouteParams -> List Head.Tag
head app =
    []


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    { title = "Impressum"
    , body =
        [ Html.div
            [ style "max-width" "800px"
            , style "margin-left" "auto"
            , style "margin-right" "auto"
            ]
            [ Html.h2 [] [ Html.text "Impressum" ]
            , Html.p [ style "font-style" "italic" ]
                [ text "Youwen Wu"
                , Html.br [] []
                , text "University of California"
                , Html.br [] []
                , text "Santa Barbara, CA"
                , Html.br [] []
                , text "United States of America"
                , Html.br [ style "margin" "0 0 1em 0" ] []
                , text "Contact: youwen (at) ucsb.edu"
                , Html.br [] []
                , span [ style "font-style" "normal", style "font-family" "monospace" ] [ text "D26A 0082 4013D524 BDF1 1126 093F 1185 C55B 84A2" ]
                , Html.br [] []
                , text "Or: "
                , text "youwenw (at) gmail.com"
                , Html.br [] []
                , span [ style "font-style" "normal", style "font-family" "monospace" ] [ text "8F5E 6C1A F909 76CA 7102 917A 8656 58ED 1FE6 1EC3" ]
                , Html.br [] []
                , text "Keys available in "
                , a [ href "https://keys.openpgp.org/" ] [ text "OpenPGP" ]
                , text " and "
                , a [ href "https://pgp.mit.edu/" ] [ text "MIT" ]
                , text " keyservers."
                ]
            , Html.h2 [] [ Html.text "Colophon" ]
            , Html.p []
                [ Html.text "Typeface: "
                , a [ href "https://www.redaction.us/" ] [ text "redaction" ]
                , text ", a bespoke typeface designed as part of the Redaction project to highlight abuses in the criminal justice system."
                ]
            ]
        ]
    }


action :
    RouteParams
    -> Server.Request.Request
    -> BackendTask.BackendTask FatalError.FatalError (Server.Response.Response ActionData ErrorPage.ErrorPage)
action routeParams request =
    BackendTask.succeed (Server.Response.render {})
