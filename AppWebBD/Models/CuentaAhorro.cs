using System;

namespace AppWebBD.Models
{
    public class CuentaAhorro
    {
        public int Clienteid { get; set; }
        public int TipoCuentaid { get; set; }
        public long NumeroCuenta { get; set; }
        public string FechaCreacion { get; set; }
        public double Saldo { get; set; }
    }
}
