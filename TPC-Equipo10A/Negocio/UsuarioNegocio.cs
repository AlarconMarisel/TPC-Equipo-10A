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
                    
                    // Campos obligatorios
                    user.IdUsuario = Convert.ToInt32(datos.Lector["IdUsuario"]);
                    user.Email = datos.Lector["Email"] != DBNull.Value ? Convert.ToString(datos.Lector["Email"]) : null;
                    user.Password = datos.Lector["Password"] != DBNull.Value ? Convert.ToString(datos.Lector["Password"]) : null;
                    user.Nombre = datos.Lector["Nombre"] != DBNull.Value ? Convert.ToString(datos.Lector["Nombre"]) : null;
                    user.Apellido = datos.Lector["Apellido"] != DBNull.Value ? Convert.ToString(datos.Lector["Apellido"]) : null;
                    
                    // Campos opcionales
                    user.Dni = datos.Lector["Dni"] != DBNull.Value ? Convert.ToString(datos.Lector["Dni"]) : null;
                    user.Telefono = datos.Lector["Telefono"] != DBNull.Value ? Convert.ToString(datos.Lector["Telefono"]) : null;
                    user.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? Convert.ToString(datos.Lector["Domicilio"]) : null;
                    
                    // TipoUsuario - puede ser TINYINT (0-255)
                    if (datos.Lector["TipoUsuario"] != DBNull.Value)
                    {
                        byte tipoUsuarioValue = Convert.ToByte(datos.Lector["TipoUsuario"]);
                        user.Tipo = (TipoUsuario)tipoUsuarioValue;
                    }
                    else
                    {
                        user.Tipo = TipoUsuario.NORMAL;
                    }
                    
                    // Campos de multi-tenancy
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? (int?)Convert.ToInt32(datos.Lector["IDAdministrador"]) : null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? Convert.ToString(datos.Lector["NombreTienda"]) : null;
                    
                    // Fechas
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(datos.Lector["FechaAlta"]) : null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(datos.Lector["FechaVencimiento"]) : null;
                    
                    // Booleanos
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Activo"]);
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Eliminado"]);
                    
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
                    user.IdUsuario = Convert.ToInt32(datos.Lector["IdUsuario"]);
                    user.Nombre = datos.Lector["Nombre"] != DBNull.Value ? (string)datos.Lector["Nombre"] : null;
                    user.Apellido = datos.Lector["Apellido"] != DBNull.Value ? (string)datos.Lector["Apellido"] : null;
                    user.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : null;
                    user.Password = datos.Lector["Password"] != DBNull.Value ? (string)datos.Lector["Password"] : null;
                    user.Dni = datos.Lector["Dni"] != DBNull.Value ? (string)datos.Lector["Dni"] : null;
                    user.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : null;
                    user.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : null;
                    user.Tipo = datos.Lector["TipoUsuario"] != DBNull.Value ? (TipoUsuario)Convert.ToByte(datos.Lector["TipoUsuario"]) : TipoUsuario.NORMAL;
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? (int?)Convert.ToInt32(datos.Lector["IDAdministrador"]) : null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? (string)datos.Lector["NombreTienda"] : null;
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? (DateTime?)datos.Lector["FechaAlta"] : null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? (DateTime?)datos.Lector["FechaVencimiento"] : null;
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Activo"]);
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Eliminado"]);
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


        // METODOS PARA SUPERADMIN

        public List<Usuario> ListarAdministradores()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdUsuario, Nombre, Apellido, Email, TipoUsuario, IDAdministrador, NombreTienda, FechaAlta, FechaVencimiento, Activo, Eliminado FROM USUARIOS WHERE TipoUsuario = 1 AND Eliminado = 0 ORDER BY FechaAlta DESC");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuario user = new Usuario();
                    user.IdUsuario = Convert.ToInt32(datos.Lector["IdUsuario"]);
                    user.Nombre = datos.Lector["Nombre"] != DBNull.Value ? (string)datos.Lector["Nombre"] : null;
                    user.Apellido = datos.Lector["Apellido"] != DBNull.Value ? (string)datos.Lector["Apellido"] : null;
                    user.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : null;
                    user.Tipo = datos.Lector["TipoUsuario"] != DBNull.Value ? (TipoUsuario)Convert.ToByte(datos.Lector["TipoUsuario"]) : TipoUsuario.NORMAL;
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? (int?)Convert.ToInt32(datos.Lector["IDAdministrador"]) : null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? (string)datos.Lector["NombreTienda"] : null;
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? (DateTime?)datos.Lector["FechaAlta"] : null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? (DateTime?)datos.Lector["FechaVencimiento"] : null;
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Activo"]);
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Eliminado"]);
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

        public int CrearAdministradorConCategorias(Usuario nuevoAdmin, DateTime? fechaVencimiento)
        {
            AccesoDatos datos = new AccesoDatos();
            int idAdministradorCreado = 0;
            try
            {
                // Crea el administrador
                datos.SetearConsulta(@"INSERT INTO USUARIOS (Email, Password, DNI, Nombre, Apellido, Telefono, Domicilio, TipoUsuario, IDAdministrador, FechaAlta, FechaVencimiento, Activo, Eliminado, NombreTienda)
                                       VALUES (@Email, @Password, @DNI, @Nombre, @Apellido, @Telefono, @Domicilio, 1, NULL, GETDATE(), @FechaVencimiento, @Activo, 0, NULL);
                                       SELECT SCOPE_IDENTITY();");
                
                datos.SetearParametro("@Email", nuevoAdmin.Email);
                datos.SetearParametro("@Password", nuevoAdmin.Password);
                datos.SetearParametro("@DNI", (object)nuevoAdmin.Dni ?? DBNull.Value);
                datos.SetearParametro("@Nombre", nuevoAdmin.Nombre);
                datos.SetearParametro("@Apellido", nuevoAdmin.Apellido);
                datos.SetearParametro("@Telefono", (object)nuevoAdmin.Telefono ?? DBNull.Value);
                datos.SetearParametro("@Domicilio", (object)nuevoAdmin.Domicilio ?? DBNull.Value);
                datos.SetearParametro("@FechaVencimiento", (object)fechaVencimiento ?? DBNull.Value);
                datos.SetearParametro("@Activo", nuevoAdmin.Activo);

                object result = datos.EjecutarAccionScalar();
                idAdministradorCreado = Convert.ToInt32(result);

                datos.cerrarConexion();

                // Crea categorias por defecto
                if (idAdministradorCreado > 0)
                {
                    CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                    categoriaNegocio.CrearCategoriasPorDefecto(idAdministradorCreado);
                }

                return idAdministradorCreado;
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

        public void ActivarDesactivarAdministrador(int idAdministrador, bool activo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE USUARIOS SET Activo = @Activo WHERE IdUsuario = @IdUsuario AND TipoUsuario = 1");
                datos.SetearParametro("@Activo", activo);
                datos.SetearParametro("@IdUsuario", idAdministrador);
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

        public void ActualizarFechaVencimiento(int idAdministrador, DateTime? fechaVencimiento)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE USUARIOS SET FechaVencimiento = @FechaVencimiento WHERE IdUsuario = @IdUsuario AND TipoUsuario = 1");
                datos.SetearParametro("@FechaVencimiento", (object)fechaVencimiento ?? DBNull.Value);
                datos.SetearParametro("@IdUsuario", idAdministrador);
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

        /// <summary>
        /// Lista los usuarios normales de un administrador específico
        /// </summary>
        public List<Usuario> ListarUsuariosNormales(int idAdministrador)
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta(@"
                    SELECT IdUsuario, Nombre, Apellido, Email, Password, DNI, Telefono, Domicilio, 
                           TipoUsuario, IDAdministrador, NombreTienda, FechaAlta, FechaVencimiento, Activo, Eliminado 
                    FROM USUARIOS 
                    WHERE TipoUsuario = 0 
                    AND IDAdministrador = @IDAdministrador
                    ORDER BY FechaAlta DESC");

                datos.SetearParametro("@IDAdministrador", idAdministrador);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario user = new Usuario();
                    user.IdUsuario = Convert.ToInt32(datos.Lector["IdUsuario"]);
                    user.Nombre = datos.Lector["Nombre"] != DBNull.Value ? (string)datos.Lector["Nombre"] : null;
                    user.Apellido = datos.Lector["Apellido"] != DBNull.Value ? (string)datos.Lector["Apellido"] : null;
                    user.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : null;
                    user.Password = datos.Lector["Password"] != DBNull.Value ? (string)datos.Lector["Password"] : null;
                    user.Dni = datos.Lector["DNI"] != DBNull.Value ? (string)datos.Lector["DNI"] : null;
                    user.Telefono = datos.Lector["Telefono"] != DBNull.Value ? (string)datos.Lector["Telefono"] : null;
                    user.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : null;
                    user.Tipo = (TipoUsuario)Convert.ToByte(datos.Lector["TipoUsuario"]);
                    user.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : (int?)null;
                    user.NombreTienda = datos.Lector["NombreTienda"] != DBNull.Value ? (string)datos.Lector["NombreTienda"] : null;
                    user.FechaAlta = datos.Lector["FechaAlta"] != DBNull.Value ? Convert.ToDateTime(datos.Lector["FechaAlta"]) : (DateTime?)null;
                    user.FechaVencimiento = datos.Lector["FechaVencimiento"] != DBNull.Value ? Convert.ToDateTime(datos.Lector["FechaVencimiento"]) : (DateTime?)null;
                    user.Activo = datos.Lector["Activo"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Activo"]);
                    user.Eliminado = datos.Lector["Eliminado"] != DBNull.Value && Convert.ToBoolean(datos.Lector["Eliminado"]);
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

        /// <summary>
        /// Da de baja un usuario (soft delete)
        /// </summary>
        public void DarDeBajaUsuario(int idUsuario, int idAdministrador)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Validar que el usuario pertenece al administrador
                datos.SetearConsulta("SELECT IDAdministrador FROM USUARIOS WHERE IdUsuario = @IdUsuario AND TipoUsuario = 0");
                datos.SetearParametro("@IdUsuario", idUsuario);
                datos.EjecutarLectura();

                if (!datos.Lector.Read())
                {
                    throw new Exception("Usuario no encontrado.");
                }

                int? idAdminUsuario = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : (int?)null;

                if (!idAdminUsuario.HasValue || idAdminUsuario.Value != idAdministrador)
                {
                    throw new Exception("No tiene permisos para gestionar este usuario.");
                }

                datos.cerrarConexion();

                // Actualizar eliminado
                datos.SetearConsulta("UPDATE USUARIOS SET Eliminado = 1 WHERE IdUsuario = @IdUsuario");
                datos.SetearParametro("@IdUsuario", idUsuario);
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

        /// <summary>
        /// Reactiva un usuario (quita soft delete)
        /// </summary>
        public void ReactivarUsuario(int idUsuario, int idAdministrador)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Validar que el usuario pertenece al administrador
                datos.SetearConsulta("SELECT IDAdministrador FROM USUARIOS WHERE IdUsuario = @IdUsuario AND TipoUsuario = 0");
                datos.SetearParametro("@IdUsuario", idUsuario);
                datos.EjecutarLectura();

                if (!datos.Lector.Read())
                {
                    throw new Exception("Usuario no encontrado.");
                }

                int? idAdminUsuario = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : (int?)null;

                if (!idAdminUsuario.HasValue || idAdminUsuario.Value != idAdministrador)
                {
                    throw new Exception("No tiene permisos para gestionar este usuario.");
                }

                datos.cerrarConexion();

                // Actualizar eliminado
                datos.SetearConsulta("UPDATE USUARIOS SET Eliminado = 0 WHERE IdUsuario = @IdUsuario");
                datos.SetearParametro("@IdUsuario", idUsuario);
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

        /// <summary>
        /// Actualiza el nombre de tienda de un administrador
        /// </summary>
        public void ActualizarNombreTienda(int idAdministrador, string nombreTienda)
        {
            // Validar que el nombre de tienda sea único (si se proporciona)
            if (!string.IsNullOrEmpty(nombreTienda))
            {
                AccesoDatos datosValidacion = new AccesoDatos();
                try
                {
                    datosValidacion.SetearConsulta("SELECT COUNT(*) FROM USUARIOS WHERE NombreTienda = @NombreTienda AND IdUsuario != @IdAdministrador AND Eliminado = 0");
                    datosValidacion.SetearParametro("@NombreTienda", nombreTienda);
                    datosValidacion.SetearParametro("@IdAdministrador", idAdministrador);
                    object result = datosValidacion.EjecutarAccionScalar();

                    if (Convert.ToInt32(result) > 0)
                    {
                        throw new Exception("El nombre de tienda ya está en uso.");
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    datosValidacion.cerrarConexion();
                }
            }

            // Actualizar nombre de tienda (usar objeto separado para evitar conflictos de parámetros)
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE USUARIOS SET NombreTienda = @NombreTienda WHERE IdUsuario = @IdAdministrador AND TipoUsuario = 1");
                datos.SetearParametro("@NombreTienda", (object)nombreTienda ?? DBNull.Value);
                datos.SetearParametro("@IdAdministrador", idAdministrador);
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

    }
}
