using System;

namespace AppWebBD.Models
{
    public class Beneficiarios
    {
        public long NumeroCuenta { get; set; }
        public int ValorDocumentoIdentidadBeneficiario { get; set; }
        public int ParentezcoId { get; set; }
        public int Porcentaje { get; set; }
        public Boolean Activo { get; set; }
        public string FechaDesactivacion { get; set; }

    }
}
