  
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Template.Actionable.Data.Models
{
    public class Widget
    {
        [Key]
        public System.Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }
}