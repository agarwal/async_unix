open! Core.Std
open! Import
open Async_kernel.Clock_ns

let run_at    time f a = run_at    (Time_ns.of_time      time) f a
let run_after span f a = run_after (Time_ns.Span.of_span span) f a

let at    time = at    (Time_ns.of_time time)
let after span = after (Time_ns.Span.of_span span)

let with_timeout span d = with_timeout (Time_ns.Span.of_span span) d

module Event = struct
  type ('a, 'h) t = ('a, 'h) Event.t with sexp_of

  type t_unit = Event.t_unit with sexp_of

  let invariant = Event.invariant

  let abort             = Event.abort
  let abort_exn         = Event.abort_exn
  let abort_if_possible = Event.abort_if_possible
  let fired             = Event.fired

  let scheduled_at t = Time_ns.to_time (Event.scheduled_at t)

  let at    time = Event.at    (Time_ns.of_time time)
  let after span = Event.after (Time_ns.Span.of_span span)

  let reschedule_at    t time = Event.reschedule_at    t (Time_ns.of_time      time)
  let reschedule_after t span = Event.reschedule_after t (Time_ns.Span.of_span span)

  let run_at    time f x = Event.run_at    (Time_ns.of_time time)      f x
  let run_after span f x = Event.run_after (Time_ns.Span.of_span span) f x

  let status t =
    match Event.status t with
    | `Happened _ | `Aborted _ as x -> x
    | `Scheduled_at time -> `Scheduled_at (Time_ns.to_time time)
  ;;
end

let at_varying_intervals ?stop f =
  at_varying_intervals ?stop (fun () -> (Time_ns.Span.of_span (f ())))
;;

let at_intervals ?start ?stop span =
  let start = Option.map start ~f:Time_ns.of_time in
  at_intervals ?start ?stop (Time_ns.Span.of_span span)
;;

let every' ?start ?stop ?continue_on_error span f =
   every' ?start ?stop ?continue_on_error (Time_ns.Span.of_span span) f
;;

let every ?start ?stop ?continue_on_error span f =
   every ?start ?stop ?continue_on_error (Time_ns.Span.of_span span) f
;;

let run_at_intervals' ?start ?stop ?continue_on_error span f =
  let start = Option.map start ~f:Time_ns.of_time in
  run_at_intervals' ?start ?stop ?continue_on_error (Time_ns.Span.of_span span) f
;;

let run_at_intervals ?start ?stop ?continue_on_error span f =
  let start = Option.map start ~f:Time_ns.of_time in
  run_at_intervals ?start ?stop ?continue_on_error (Time_ns.Span.of_span span) f
;;
