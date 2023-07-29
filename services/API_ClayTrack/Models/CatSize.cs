﻿using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_ClayTrack.Models
{
    public class CatSize
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int idCatSize { get; set; }

        [Required]
        [StringLength(255)]
        public string description { get; set; }

        [Required]
        [StringLength(255)]
        public string abbreviation { get; set; }

        [Required]
        public bool status { get; set; }

        [Required]
        public DateTime creationDate { get; set; }

        [Required]
        public DateTime updateDate { get; set; }
    }
}
