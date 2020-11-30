using AppWebBD.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AppWebBD.Context
{
    public class SP_VerificarPorcentajeBeneficiarios
    {
        string connectionString = "Data Source=proyectobd.cwzzdv93j6mm.us-east-2.rds.amazonaws.com;Initial Catalog=ProyectoBD1;User ID=Admin;Password= AdminAWS123";
        public string VerificarPorcentaje(int? NumeroCuenta) //El signo de pregunta sirve para generar un error si el contenido es NULL
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("SP_VerificarPorcentajeBeneficiarios", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@inNumeroCuenta", NumeroCuenta);
            var codigoRetorno = cmd.Parameters.Add("@outErrorCode", SqlDbType.Int);
            codigoRetorno.Direction = ParameterDirection.ReturnValue;

            con.Open();
            cmd.ExecuteNonQuery();
            int resultado = Int32.Parse(codigoRetorno.Value.ToString());

            string msg = null;
            if(resultado == 5007)
            {
                msg = "La suma de los porcentajes de sus beneficiarios no suma 100, favor corregir";
            }else if (resultado  == 5008){
                msg = "La suma de los porcentajes de sus beneficiarios suma más 100, favor corregir";
            }

            con.Close();
            return msg;
        }

    }
}
