using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Template.Actionable.Data.Models {
    public class Template.ActionableDbContext : DbContext {
        public Template.ActionableDbContext (DbContextOptions<Template.ActionableDbContext> options) : base (options) { }
        public Template.ActionableDbContext () { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        { 
            // FIXME: Pull this information from somewhere else
            // https://stackoverflow.com/questions/52156484/how-exactly-does-microsoft-extensions-configuration-dependent-on-asp-net-core
            // https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-2.1
            // https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.configuration.jsonconfigurationextensions.addjsonfile?view=aspnetcore-2.2#Microsoft_Extensions_Configuration_JsonConfigurationExtensions_AddJsonFile_Microsoft_Extensions_Configuration_IConfigurationBuilder_System_String_
            var connectionString = "User ID=samplesam;Password=Password1;Host=pomodoro-pgsql;Port=5432;Database=Template.ActionableDb;Pooling=true;";
            optionsBuilder.UseNpgsql(connectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder
                .Entity<UserEventEnvelopeEntity>()
                .HasKey(e => new { e.StreamId, e.UserId, e.Id });

            // modelBuilder
            //     .Entity<GroupPrincipalMap>()
            //     .HasKey(e => new { e.GroupId, e.PrincipalId });

            // modelBuilder
            //     .Entity<RolePrincipalMap>()
            //     .HasKey(e => new { e.RoleId, e.PrincipalId });

            // Some samples from the Toastmasters example. 
            
            // modelBuilder.Entity<RoleRequestEnvelopeEntity>().ToTable("RoleRequestEvents");
            // modelBuilder.Entity<RolePlacementEnvelopeEntity>().ToTable("RolePlacementEvents");

            // modelBuilder
            //     .Entity<RoleRequestMeeting>()
            //     .HasKey(e => new { e.RoleRequestId, e.MeetingId });

            base.OnModelCreating(modelBuilder);
        }


        public virtual DbSet<UserEventEnvelopeEntity> UserEvents { get; set; }

        public virtual DbSet<User> Users { get; set; }
    }
}