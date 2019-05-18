  
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Template.Actionable.Data.Models
{
    public class User
    {
        [Key]
        public System.Guid Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }
}