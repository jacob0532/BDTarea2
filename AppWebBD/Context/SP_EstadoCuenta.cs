using AppWebBD.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AppWebBD.Context
{
    public class SP_EstadoCuenta
    {
        string connectionString = "Data Source=proyectobd.cwzzdv93j6mm.us-east-2.rds.amazonaws.com;Initial Catalog=ProyectoBD1;User ID=Admin;Password= AdminAWS123";
        public IEnumerable<EstadoCuenta> SeleccionarEstadoDeCuenta(int? numeroCuenta) //El signo de pregunta sirve para generar un error si el contenido es NULL
        {

            var estadosCuentasList = new List<EstadoCuenta>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("ConsultaEstadoCuenta", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@inNumeroCuenta", numeroCuenta);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var estadoCuenta = new EstadoCuenta();

                    estadoCuenta.id = Convert.ToInt32(dr["id"]);
                    estadoCuenta.NumeroCuenta = Convert.ToInt32(dr["NumeroCuenta"]);
                    estadoCuenta.FechaInicio = Convert.ToDateTime(dr["FechaInicio"]).ToString("d");
                    estadoCuenta.FechaFin = Convert.ToDateTime(dr["FechaFin"]).ToString("d");
                    estadoCuenta.SaldoInicial = Convert.ToInt64(dr["SaldoInicial"]);
                    estadoCuenta.SaldoFinal = Convert.ToInt64(dr["SaldoFinal"]);

                    estadosCuentasList.Add(estadoCuenta);

                }
                con.Close();
            }
            return estadosCuentasList;
        }
    }
}
