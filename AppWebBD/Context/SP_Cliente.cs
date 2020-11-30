using AppWebBD.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AppWebBD.Context
{
    public class SP_Cliente
    {
        string connectionString = "Data Source=proyectobd.cwzzdv93j6mm.us-east-2.rds.amazonaws.com;Initial Catalog=ProyectoBD1;User ID=Admin;Password= AdminAWS123";
        public IEnumerable<Cliente> SeleccionarClientes()
        {
            var clienteLista = new List<Cliente>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_SeleccionarClientes", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var cliente = new Cliente();
                    cliente.Nombre = dr["Nombre"].ToString();
                    cliente.ValorDocIdentidad = Convert.ToInt32(dr["ValorDocIdentidad"].ToString());
                    cliente.Email = dr["Email"].ToString();
                    cliente.FechaNacimiento = Convert.ToDateTime(dr["FechaNacimiento"]).ToString("d");
                    cliente.Telefono1 = Convert.ToInt32(dr["Telefono1"].ToString());
                    cliente.Telefono2 = Convert.ToInt32(dr["Telefono2"].ToString());
                    cliente.TipoDocIdentidadid = Convert.ToInt32(dr["TipoDocIdentidadid"].ToString());

                    clienteLista.Add(cliente);
                }
                con.Close();
            }
            return clienteLista;
        }
        public Cliente SeleccionarClientePorCedula(int? ValorDocIdentidad) //El signo de pregunta sirve para generar un error si el contenido es NULL
        {
            var cliente = new Cliente();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_SeleccionarClientePorCedula", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Cedula", ValorDocIdentidad);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    cliente.Nombre = dr["Nombre"].ToString();
                    cliente.ValorDocIdentidad = Convert.ToInt32(dr["ValorDocIdentidad"].ToString());
                    cliente.Email = dr["Email"].ToString();
                    cliente.FechaNacimiento = Convert.ToDateTime(dr["FechaNacimiento"]).ToString("d");
                    cliente.Telefono1 = Convert.ToInt32(dr["Telefono1"].ToString());
                    cliente.Telefono2 = Convert.ToInt32(dr["Telefono2"].ToString());
                    cliente.TipoDocIdentidadid = Convert.ToInt32(dr["TipoDocIdentidadid"].ToString());

                }
                con.Close();
            }
            return cliente;
        }
        public void IngresarCliente(Cliente cliente)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertarCliente", con);
                cmd.CommandType = CommandType.StoredProcedure;
             
                cmd.Parameters.AddWithValue("@inNombre",cliente.Nombre);
                cmd.Parameters.AddWithValue("@inValorDocIdentidad",cliente.ValorDocIdentidad);
                cmd.Parameters.AddWithValue("@inEmail",cliente.Email);
                cmd.Parameters.AddWithValue("@inFechaNacimiento",cliente.FechaNacimiento);
                cmd.Parameters.AddWithValue("@inTelefono1", cliente.Telefono1);
                cmd.Parameters.AddWithValue("@inTelefono2", cliente.Telefono2);
                cmd.Parameters.AddWithValue("@inTipoDocIdentidadid ", cliente.TipoDocIdentidadid);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
    }
}
