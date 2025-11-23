using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> ListarUsuarios()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdUsuario, Nombre, Apellido, Email, Password, Dni, Telefono, Domicilio, TipoUsuario, IDAdministrador, NombreTienda, FechaAlta, FechaVencimiento, Activo, Eliminado FROM USUARIOS");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuario user = new Usuario();
                    user.IdUsuario = (int)datos.Lector["IdUsuario"];
                    user.Email = (string)datos.Lector["Email"];
                    user.Password = (string)datos.Lector["Password"];
                    user.Dni = datos.Lector["Dni"] != DBNull.Value ? (string)datos.Lector["Dni"] : null;
                    user.Nombre = (string)datos.Lector["Nombre"];
                    user.Apellido = (string)datos.Lector["Apellido"];
                    user.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : null;
                    user.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : null;
                    user.Tipo = (TipoUsuario)(int)datos.Lector["TipoUsuario"];
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? (int?)datos.Lector["IDAdministrador"] : null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? (string)datos.Lector["NombreTienda"] : null;
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? (DateTime?)datos.Lector["FechaAlta"] : null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? (DateTime?)datos.Lector["FechaVencimiento"] : null;
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && (bool)datos.Lector["Activo"];
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && (bool)datos.Lector["Eliminado"];
                    lista.Add(user);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
            
        }

        public void AgregarUsuarioConSP(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("SP_AgregarUsuario");
                datos.SetearParametro("@Nombre", nuevo.Nombre);
                datos.SetearParametro("@Apellido", nuevo.Apellido);
                datos.SetearParametro("@Email", nuevo.Email);
                datos.SetearParametro("@Password", nuevo.Password);
                datos.SetearParametro("@Dni", (object)nuevo.Dni ?? DBNull.Value);
                datos.SetearParametro("@Telefono", (object)nuevo.Telefono ?? DBNull.Value);
                datos.SetearParametro("@Domicilio", (object)nuevo.Domicilio ?? DBNull.Value);
                datos.SetearParametro("@TipoUsuario", (int)nuevo.Tipo);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ModificarUsuario(Usuario user)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE USUARIOS SET Nombre=@Nombre, Apellido=@Apellido, Email=@Email, Password=@Password, Dni=@Dni, Telefono=@Telefono, Domicilio=@Domicilio, TipoUsuario=@TipoUsuario, IDAdministrador=@IDAdministrador, NombreTienda=@NombreTienda, FechaAlta=@FechaAlta, FechaVencimiento=@FechaVencimiento, Activo=@Activo, Eliminado=@Eliminado WHERE IdUsuario=@IdUsuario");
                datos.SetearParametro("@Nombre", user.Nombre);
                datos.SetearParametro("@Apellido", user.Apellido);
                datos.SetearParametro("@Email", user.Email);
                datos.SetearParametro("@Password", user.Password);
                datos.SetearParametro("@Dni", (object)user.Dni ?? DBNull.Value);
                datos.SetearParametro("@Telefono", (object)user.Telefono ?? DBNull.Value);
                datos.SetearParametro("@Domicilio", (object)user.Domicilio ?? DBNull.Value);
                datos.SetearParametro("@TipoUsuario", (int)user.Tipo);
                datos.SetearParametro("@IDAdministrador", (object)user.IDAdministrador ?? DBNull.Value);
                datos.SetearParametro("@NombreTienda", (object)user.NombreTienda ?? DBNull.Value);
                datos.SetearParametro("@FechaAlta", (object)user.FechaAlta ?? DBNull.Value);
                datos.SetearParametro("@FechaVencimiento", (object)user.FechaVencimiento ?? DBNull.Value);
                datos.SetearParametro("@Activo", user.Activo);
                datos.SetearParametro("@Eliminado", user.Eliminado);
                datos.SetearParametro("@IdUsuario", user.IdUsuario);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Usuario ObtenerPorId(int id)
        {
            Usuario user = null;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdUsuario, Nombre, Apellido, Email, Password, Dni, Telefono, Domicilio, TipoUsuario, IDAdministrador, NombreTienda, FechaAlta, FechaVencimiento, Activo, Eliminado FROM USUARIOS WHERE IdUsuario = @IdUsuario");
                datos.SetearParametro("@IdUsuario", id);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    user = new Usuario();
                    user.IdUsuario = (int)datos.Lector["IdUsuario"];
                    user.Nombre = datos.Lector["Nombre"] != DBNull.Value ? (string)datos.Lector["Nombre"] : null;
                    user.Apellido = datos.Lector["Apellido"] != DBNull.Value ? (string)datos.Lector["Apellido"] : null;
                    user.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : null;
                    user.Password = datos.Lector["Password"] != DBNull.Value ? (string)datos.Lector["Password"] : null;
                    user.Dni = datos.Lector["Dni"] != DBNull.Value ? (string)datos.Lector["Dni"] : null;
                    user.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : null;
                    user.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : null;
                    user.Tipo = (TipoUsuario)(int)datos.Lector["TipoUsuario"];
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? (int?)datos.Lector["IDAdministrador"] : null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? (string)datos.Lector["NombreTienda"] : null;
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? (DateTime?)datos.Lector["FechaAlta"] : null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? (DateTime?)datos.Lector["FechaVencimiento"] : null;
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && (bool)datos.Lector["Activo"];
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && (bool)datos.Lector["Eliminado"];
                }

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
