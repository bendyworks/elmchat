module Main exposing (..)


import Html
import Time exposing (second, every)

import Model exposing (model)
import Update exposing (update)
import View exposing (view)
import Types exposing (Chat, Msg(PollMessages))
import Task

prefetchMessages : Cmd Msg
prefetchMessages =
  Task.perform
    (always PollMessages)
    (Task.succeed ())


init : (Chat, Cmd Msg)
init = (model, prefetchMessages)

messageSubscription : Chat -> Sub Msg
messageSubscription _ =
  every (5 * second) (always PollMessages)


main : Program Never Chat Msg
main =
  Html.program
    { init = init, update = update, view = view, subscriptions = messageSubscription }
