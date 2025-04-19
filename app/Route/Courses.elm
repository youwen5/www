module Route.Courses exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import BackendTask.Http
import Css exposing (auto, marginLeft, marginRight, maxWidth, px)
import ErrorPage exposing (ErrorPage)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Html.Styled exposing (a, div, h1, h2, li, p, text, toUnstyled, ul)
import Html.Styled.Attributes exposing (alt, css, href, src, style, width)
import Json.Decode as Decode
import List exposing (map)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute, StatelessRoute)
import Server.Request as Request exposing (Request)
import Server.Response as Response exposing (Response)
import Shared
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.serverRender
        { head = head
        , data = data
        , action = \_ _ -> BackendTask.fail (FatalError.fromString "No action.")
        }
        |> RouteBuilder.buildNoState { view = view }


type alias Data =
    {}


type alias ActionData =
    {}


data : RouteParams -> Request -> BackendTask FatalError (Response Data ErrorPage)
data routeParams request =
    BackendTask.succeed
        (Response.render
            {}
        )


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Youwen Wu"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "courses ive taken at ucsb"
        , locale = Nothing
        , title = "courses | Youwen Wu" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "courses | Youwen Wu"
    , body =
        map toUnstyled
            [ div [ css [ maxWidth (px 800), marginLeft auto, marginRight auto ] ]
                [ h1 [] [ text "math/cs courses ive taken" ]
                , h2 [] [ text "fall 2024" ]
                , ul []
                    [ li [] [ text "math4a - fake linear algebra for dummies (A+)" ]
                    ]
                , h2 [] [ text "winter 2025" ]
                , ul []
                    [ li [] [ text "math4b - ordinary differential equations (A-)" ]
                    , li [] [ text "math6a - vector calculus, first course (A)" ]
                    , li [] [ text "math8 - discrete math / intro to proofs (A)" ]
                    , li [] [ text "pstat120a - probability theory (A)" ]
                    , li [] [ text "cs16 - problem solving with c++ (A)" ]
                    ]
                , h2 [] [ text "spring 2025" ]
                , ul []
                    [ li [] [ text "math108a - abstract linear algebra" ]
                    , li [] [ text "math6b - vector calculus, second course" ]
                    , li [] [ text "math117 - intro to real analysis" ]
                    , li [] [ text "cs24 - problem solving with c++" ]
                    ]
                ]
            ]
    }
