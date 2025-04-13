module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Css exposing (auto, marginLeft, marginRight, maxWidth, px)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html.Styled exposing (a, b, div, h1, h2, i, img, li, p, table, td, text, toUnstyled, tr, ul)
import Html.Styled.Attributes exposing (alt, css, href, src, style, width)
import List exposing (map)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "please sir im tired of winning")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Web | Youwen Wu"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "a quiet corner of the world wide web"
        , locale = Nothing
        , title = "youwen wu's personal site"
        }
        |> Seo.website


body : { a | data : { b | message : String } } -> c -> List (Html.Styled.Html msg)
body app shared =
    [ div [ css [ maxWidth (px 800), marginLeft auto, marginRight auto ] ]
        [ h1 [] [ text "Youwen Wu" ]
        , p [ style "max-width" "800px" ]
            [ text <| "the message of the day is: " ++ app.data.message
            ]
        , p [ style "max-width" "800px" ]
            [ text "hi, im youwen. i study (pure) math and computer science at ucsb. i like transit and urban planning and functional programming and linux and foss and algebra and other generally good things such as the wind gently rustling through the leaves as i stroll through the park."
            ]
        , p []
            [ text "some things i've worked on:"
            , ul []
                [ li [] [ a [ href "https://github.com/nixos/nixpkgs" ] [ text "nixos/nixpkgs" ] ]
                , li [] [ a [ href "https://github.com/youwen5/jankboard" ] [ text "team-1280/jankboard" ] ]
                , li [] [ a [ href "https://github.com/zen-browser/www" ] [ text "zen-browser/desktop" ] ]
                ]
            ]
        , p [ style "max-width" "800px" ]
            [ a [ href "/courses" ] [ text "a list of the courses ive taken at ucsb." ]
            ]
        , p [ style "max-width" "800px" ]
            [ text "software i use, for nerds who care:"
            , ul []
                [ li [] [ text "distro: ", a [ href "https://nixos.org" ] [ text "NixOS" ] ]
                , li [] [ text "desktop environment: ", a [ href "https://hyprland.org" ] [ text "hyprland" ] ]
                , li [] [ text "kernel: linux-zen" ]
                , li [] [ text "terminal: kitty" ]
                , li [] [ text "editor: ", a [ href "https://github.com/youwen5/viminal2" ] [ text "neovim" ] ]
                , li [] [ text "bar: waybar" ]
                , li [] [ text "login shell: ", a [ href "https://nushell.sh" ] [ text "nushell" ] ]
                , li [] [ text "programming language: the best one for the task, but usually Rust/Haskell/Elm" ]
                ]
            ]
        , h2 [] [ text "about this site" ]
        , p [ style "max-width" "800px" ]
            [ text "welcome to my quiet corner of the www! i continuously stay up to date with the latest trends in software development so i can do the exact opposite. i intend for this site to be a love letter to the web and what it represents -- namely, the free and unfettered exchange of information and human thought. to that effect, i promise to never ship you GenAI slop (an insult to human life itself), or talk about JavaScript (the antithesis of rational thought)."
            ]
        , p [ style "max-width" "800px" ]
            [ text "this site was built with "
            , a [ href "https://elm-lang.org/" ] [ text "elm" ]
            , text ", a purely functional programming language for writing web apps. it allows you to program for the web in a sane fashion, eschewing all mainstream frameworks and languages, and ruling out entire classes of pathologic behavior through careful design of types. all without writing a single line resembling html/css/js."
            ]
        , p [ style "max-width" "800px" ]
            [ text "unfortunately, this has some undesired side effects. you may have noticed this site is entirely empty and unstyled. this unfortunate reality is due to the fact that ive been far too busy scaffolding the theoretical foundations of the site and pondering the mathematical structure of its type system to actually learn how to do CSS, or write any content."
            ]
        , p [ style "max-width" "800px" ]
            [ text "my old site, which looks considerably nicer, written using Svelte, is available here for now: "
            , a [ href "https://youwen.dev" ] [ text "https://youwen.dev" ]
            , text ", while i migrate over to this one."
            ]
        , div [ style "max-width" "800px" ]
            [ table []
                [ tr []
                    [ td []
                        [ img
                            [ src "http://math.jhu.edu/~savitt/GTM/massey.jpg"
                            , width 200
                            , alt ""
                            ]
                            []
                        ]
                    , td []
                        [ p []
                            [ text "If I were a Springer-Verlag Graduate Text in Mathematics, I would be William S. Massey's "
                            , b []
                                [ i []
                                    [ text "A Basic Course in Algebraic Topology" ]
                                ]
                            , text "."
                            ]
                        , p []
                            [ text " I am intended to serve as a textbook for a course in algebraic topology at the beginning graduate level. The main topics covered are the classification of compact 2-manifolds, the fundamental group, covering spaces, singular homology theory, and singular cohomology theory. These topics are developed systematically, avoiding all unecessary definitions, terminology, and technical machinery. Wherever possible, the geometric motivation behind the various concepts is emphasized. " ]
                        , p []
                            [ text "Which Springer GTM would "
                            , i []
                                [ text "you" ]
                            , text " be? "
                            , a
                                [ href "http://math.jhu.edu/~savitt/GTM.html"
                                ]
                                [ text "The Springer GTM Test" ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "welcome"
    , body = map toUnstyled (body app shared)
    }
