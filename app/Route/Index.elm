module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Css exposing (auto, em, fontSize, marginLeft, marginRight, maxWidth, px)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html.Styled exposing (a, b, div, h1, h2, i, img, li, p, table, td, text, toUnstyled, tr, ul)
import Html.Styled.Attributes exposing (alt, css, href, src, width)
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
            (BackendTask.succeed "glorp")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Youwen Wu's personal website"
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
        [ p []
            [ text "Hi! Welcome to my site on the World Wide Web. I study (pure) math and computer science at "
            , a [ href "https://ucsb.edu" ] [ text "UC Santa Barbara" ]
            , text " (co 2028). I like public transit and urban planning and functional programming and music and foss and abstract algebra and other generally good things such as the wind gently rustling through the leaves as I stroll through the park."
            ]
        , p []
            [ text "Here is my "
            , a [ href "/courses" ] [ text "university transcript" ]
            , text ", "
            , a [ href "https://github.com/youwen5" ] [ text "GitHub" ]
            , text ", "
            , a [ href "https://www.last.fm/user/couscousdude" ] [ text "last.fm" ]
            , text ", and "
            , a [ href "/static/img/cat_babies.jpg" ] [ text "a picture of my cats." ]
            ]
        , p []
            [ text "Outside of math, I play guitar and spend way too much money on guitar pedals. I also hate coding."
            ]
        , p []
            [ text "Some things i've worked on:"
            , ul []
                [ li [] [ a [ href "https://github.com/nixos/nixpkgs" ] [ text "nixos/nixpkgs" ], text " (nixpkgs package repository and the NixOS linux distribution)" ]
                , li [] [ a [ href "https://github.com/youwen5/jankboard" ] [ text "team-1280/jankboard" ], text " (FRC Team 1280 robot control dashboard with 3D visuals)" ]
                , li [] [ a [ href "https://github.com/zen-browser/desktop" ] [ text "zen-browser/desktop" ], text " (cool firefox-based browser)" ]
                , li [] [ a [ href "https://virion.youwen.dev" ] [ text "youwen5/virion" ], text " (crummy compartmental epidemic modeling in 3D, finalist proj at ucsb datathon)" ]
                ]
            ]
        , p []
            [ text "This page is a sprawling mess right now! I'm in the middle of migrating from my old Svelte-based site to this Elm-based site. My old site is considerably more polished and still available at "
            , a [ href "https://youwen.dev" ] [ text "https://youwen.dev" ]
            , text ", while i find some time to work on this one."
            ]
        , p []
            [ text "To contact me, see the "
            , a [ href "/impressum" ] [ text "impressum" ]
            , text "."
            ]
        , p []
            [ text "I use "
            , a [ href "https://nixos.org" ] [ text "NixOS" ]
            , text " (harder "
            , a [ href "/static/img/archvsnixos.webp" ] [ text "than arch" ]
            , text " btw)"
            , text ". Some setup details:"
            , ul []
                [ li [] [ text "window manager: ", a [ href "https://hyprland.org" ] [ text "hyprland" ], text " with a ", a [ href "https://github.com/dawsers/hyprscroller" ] [ text "scrolling layout" ] ]
                , li [] [ text "kernel: linux-zen" ]
                , li [] [ text "terminal: kitty" ]
                , li [] [ text "editor: ", a [ href "https://github.com/youwen5/viminal2" ] [ text "neovim" ] ]
                , li [] [ text "bar: waybar" ]
                , li [] [ text "login shell: ", a [ href "https://nushell.sh" ] [ text "nushell" ] ]
                , li [] [ text "programming language: the best one for the task, but usually Rust/Haskell/Elm" ]
                , li [] [ text "DAW: ", a [ href "https://www.reaper.fm/" ] [ text "reaper" ] ]
                ]
            ]
        , h2 [] [ text "cool things ive read/watched/played recently" ]
        , ul []
            [ li [] [ a [ href "https://arxiv.org/pdf/math/0305282" ] [ text "A Universal Approach to Self-Referential Paradoxes, Incompleteness and Fixed Points" ], text " (nonfiction, math): a generalization of many self-referential theorems" ]
            , li [] [ a [ href "https://scp-wiki.wikidot.com/we-need-to-talk-about-fifty-five" ] [ text "There Is No Antimemetics Division" ], text " (prose, fiction)" ]
            , li [] [ a [ href "https://store.steampowered.com/app/632470/Disco_Elysium__The_Final_Cut/" ] [ text "Disco Elysium" ], text " (game, rpg): 11/10. life-changing." ]
            , li [] [ a [ href "https://anilist.co/anime/154587/Sousou-no-Frieren" ] [ text "Frieren" ], text " (anime)" ]
            ]
        , h2 [] [ text "about this site" ]
        , p []
            [ text "This is my quiet corner of the web! I continuously stay up to date with the latest trends in software development so I can do the exact opposite. I intend for this site to be a love letter to the web and what it represents - namely, the free and unfettered exchange of information and human thought. To that end, I promise nothing on this site will ever be made by GenAI."
            ]
        , p []
            [ text "This site was built with "
            , a [ href "https://elm-lang.org/" ] [ text "elm" ]
            , text ", a purely functional programming language for writing web apps. Programming in elm is delightful and lets you ignore all mainstream web trends and frameworks while ruling out entire classes of unwanted behavior through the careful design of types. All without writing a single line of HTML/CSS/JS."
            ]
        , p []
            [ text "Unfortunately, this has some undesired side effects. You may have noticed this site is entirely empty and unstyled. This unfortunate reality is due to the fact that I've been far too busy scaffolding the theoretical foundations of the site and pondering the mathematical structure of its type system to actually learn how to do CSS, or write any content."
            ]
        , p []
            [ a [ href "https://github.com/youwen5/www" ] [ text "source code of this site" ]
            ]
        , div []
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
        , h2 [] [ text "webring" ]
        , p []
            [ a [ href "https://quantum9innovation.github.io/" ] [ text "q9i" ]
            , text " - "
            , a [ href "https://web.kaitotlex.systems/" ] [ text "kaitotlex" ]
            ]
        ]
    ]


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "home"
    , body = map toUnstyled (body app shared)
    }
