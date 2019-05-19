module Template.Actionable.Api.RestQuery

open Template.Actionable.Api.Dtos

open Suave
open Suave.Successful

open Common.FSharp.Suave
open Template.Actionable.Domain

let getWidget userIdString =
  DAL.WidgetManagement.findWidgetByName userIdString
  |> convertToDto
  |> toJson 
  |> OK

let getWidgets (ctx:HttpContext) =
  DAL.WidgetManagement.getAllWidgets ()
  |> List.map convertToDto
  |> toJson
  |> OK

