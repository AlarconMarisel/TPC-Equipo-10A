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
                datos.SetearConsulta("SELECT IdUsuario, Nombre, Apellido, Email, Password, EsAdmin FROM USUARIOS");
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
                    user.Tipo = (bool)datos.Lector["EsAdmin"] ? TipoUsuario.ADMIN : TipoUsuario.NORMAL;
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
                datos.SetearParametro("@EsAdmin", nuevo.Tipo == TipoUsuario.ADMIN);
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
                datos.SetearConsulta("UPDATE USUARIOS SET Nombre=@Nombre, Apellido=@Apellido, Email=@Email, Password=@Password, Dni=@Dni, Telefono=@Telefono, Domicilio=@Domicilio, EsAdmin=@EsAdmin WHERE IdUsuario=@IdUsuario");
                datos.SetearParametro("@Nombre", user.Nombre);
                datos.SetearParametro("@Apellido", user.Apellido);
                datos.SetearParametro("@Email", user.Email);
                datos.SetearParametro("@Password", user.Password);
                datos.SetearParametro("@Dni", (object)user.Dni ?? DBNull.Value);
                datos.SetearParametro("@Telefono", (object)user.Telefono ?? DBNull.Value);
                datos.SetearParametro("@Domicilio", (object)user.Domicilio ?? DBNull.Value);
                datos.SetearParametro("@EsAdmin", user.Tipo == TipoUsuario.ADMIN);
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
                datos.SetearConsulta("SELECT IdUsuario, Nombre, Apellido, Email, Password, Dni, Telefono, Domicilio, EsAdmin FROM USUARIOS WHERE IdUsuario = @IdUsuario");
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
                    user.Tipo = datos.Lector["EsAdmin"] != DBNull.Value && (bool)datos.Lector["EsAdmin"] ? TipoUsuario.ADMIN : TipoUsuario.NORMAL;
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
