module Template.Actionable.Domain.DAL.Database

open Template.Actionable.Data.Models


let initializeDatabase () =
    use context = new Template.ActionableDbContext ()
    context.Database.EnsureDeleted () |> ignore
    context.Database.EnsureCreated () |> ignore
