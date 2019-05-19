module Template.Actionable.Api.Dtos

open Template.Actionable.Data.Models

type WidgetDto = { 
    id : string
    name : string 
    description : string }

let convertToDto (widget:Widget) = {
  WidgetDto.id = widget.Id.ToString () 
  name = widget.Name
  description = widget.Description }
