using System;

namespace AppWebBD.Models
{
    public class Cliente
    {
        public string Nombre { get; set; }
        public int ValorDocIdentidad { get; set; }
        public string Email { get; set; }
        public string FechaNacimiento { get; set; }
        public int Telefono1 { get; set; }
        public int Telefono2 { get; set; }
        public int TipoDocIdentidadid { get; set; }
    }
}
