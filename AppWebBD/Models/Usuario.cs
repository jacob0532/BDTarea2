

namespace AppWebBD.Models
{
    public class Usuario
    {
        public string User { get; set; }
        public string Pass { get; set; }
        public int ValorDocIdentidad { get; set; }
        public int EsAdmi { get; set; }  //Booleano 0 o 1

    }
}
