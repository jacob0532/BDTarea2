

namespace AppWebBD.Models
{
    public class MovimientoCuentaAhorro
    {
        public int id { get; set; }
        public string Fecha { get; set; }
        public long Monto { get; set; }
        public long NuevoSaldo { get; set; }
        public int EstadoCuentaid { get; set; }
        public int TipoMovimientoCuentaAhorrosid { get; set; }
        public int CuentaAhorroid { get; set; }
        public string Descripcion { get; set; }
    }
}
