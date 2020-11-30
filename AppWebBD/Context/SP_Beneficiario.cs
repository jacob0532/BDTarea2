using AppWebBD.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AppWebBD.Context
{
    public class SP_Beneficiario
    {
        string connectionString = "Data Source=proyectobd.cwzzdv93j6mm.us-east-2.rds.amazonaws.com;Initial Catalog=ProyectoBD1;User ID=Admin;Password= AdminAWS123";
        public IEnumerable<Beneficiarios> SeleccionarBeneficiarios(int? NumeroCuenta) //El signo de pregunta sirve para generar un error si el contenido es NULL
        {
            var beneficiarioLista = new List<Beneficiarios>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_ObtenerBeneficiarios", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@NumeroCuenta", NumeroCuenta);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var beneficiario = new Beneficiarios();
                    beneficiario.NumeroCuenta = Convert.ToInt32(dr["NumeroCuenta"]);
                    beneficiario.ValorDocumentoIdentidadBeneficiario = Convert.ToInt32(dr["ValorDocumentoIdentidadBeneficiario"]);
                    beneficiario.ParentezcoId = Convert.ToInt32(dr["ParentezcoId"]);
                    beneficiario.Porcentaje = Convert.ToInt32(dr["Porcentaje"]);
                    beneficiario.Activo = Convert.ToBoolean(dr["Activo"]);
                    if(beneficiario.FechaDesactivacion!=null)
                        beneficiario.FechaDesactivacion = Convert.ToDateTime(dr["FechaDesactivacion"]).ToString("d");
                    if(beneficiario.Activo)
                        beneficiarioLista.Add(beneficiario);
                }
                con.Close();
            }
            return beneficiarioLista;
        }

        public Beneficiarios SeleccionarBeneficiarioPorCedula(int? ValorDocumentoIdentidadBeneficiario) //El signo de pregunta sirve para generar un error si el contenido es NULL
        {
            var beneficiario = new Beneficiarios();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_BeneficiarioPorID", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ValorDocumentoIdentidadBeneficiario", ValorDocumentoIdentidadBeneficiario);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                   
                    beneficiario.NumeroCuenta = Convert.ToInt32(dr["NumeroCuenta"]);
                    beneficiario.ValorDocumentoIdentidadBeneficiario = Convert.ToInt32(dr["ValorDocumentoIdentidadBeneficiario"]);
                    beneficiario.ParentezcoId = Convert.ToInt32(dr["ParentezcoId"]);
                    beneficiario.Porcentaje = Convert.ToInt32(dr["Porcentaje"]);
                    beneficiario.Activo = Convert.ToBoolean(dr["Activo"]);
                    if (beneficiario.FechaDesactivacion != null)
                        beneficiario.FechaDesactivacion = Convert.ToDateTime(dr["FechaDesactivacion"]).ToString("d");
                }
                con.Close();
            }
            if (beneficiario.Activo)
                return beneficiario;
            else
                return null;
        }
        public void EliminarBeneficiario(int? valorDocumentoBeneficiario)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarBeneficiario", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ValorDocumentoIdentidadBeneficiario", valorDocumentoBeneficiario);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        public void AgregarBeneficiario(Beneficiarios beneficiario)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_AgregarBeneficiario", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@inNumeroCuenta", beneficiario.NumeroCuenta);
                cmd.Parameters.AddWithValue("@inValorDocIdentidadBeneficiario", beneficiario.ValorDocumentoIdentidadBeneficiario);
                cmd.Parameters.AddWithValue("@inParentezcoId", beneficiario.ParentezcoId);
                cmd.Parameters.AddWithValue("@inPorcentaje", beneficiario.Porcentaje);
                

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        public void EditarBeneficiario(Beneficiarios beneficiario, int cedulaAnterior)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_ActualizarBeneficiario", con); 
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@inNumeroCuenta", beneficiario.NumeroCuenta);
                cmd.Parameters.AddWithValue("@inValorDocumentoIdentidadBeneficiario", cedulaAnterior);
                cmd.Parameters.AddWithValue("@inNuevoDocumentoIdentidad", beneficiario.ValorDocumentoIdentidadBeneficiario);
                cmd.Parameters.AddWithValue("@inParentezcoId", beneficiario.ParentezcoId);
                cmd.Parameters.AddWithValue("@inPorcentaje", beneficiario.Porcentaje);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
    }
}
