using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ReservaNegocio
    {
        public List<Reserva> ListarReservas(int? idAdministrador = null)
        {
            List<Reserva> lista = new List<Reserva>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "";
                if (idAdministrador.HasValue)
                {
                    whereClause = "WHERE IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT IDReserva, IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva, IDAdministrador FROM RESERVAS " + whereClause);

                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Reserva aux = new Reserva();
                    aux.IdReserva = (int)datos.Lector["IDReserva"];
                    aux.IdUsuario = new Usuario { IdUsuario = (int)datos.Lector["IDUsuario"] };
                    aux.FechaReserva = (DateTime)datos.Lector["FechaReserva"];
                    aux.FechaVencimiento = (DateTime)datos.Lector["FechaVencimientoReserva"];
                    aux.MontoSeña = (decimal)datos.Lector["MontoSeña"];
                    aux.EstadoReserva = (bool)datos.Lector["EstadoReserva"];
                    aux.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    lista.Add(aux);
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

        public int AgregarReserva(Reserva nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Obtener IDAdministrador del usuario que hace la reserva
                int? idAdministrador = null;
                if (nueva.IdUsuario != null && nueva.IdUsuario.IdUsuario > 0)
                {
                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    Usuario usuario = usuarioNegocio.ObtenerPorId(nueva.IdUsuario.IdUsuario);
                    if (usuario != null)
                    {
                        idAdministrador = usuario.IDAdministrador;
                    }
                }

                // Si no se pudo obtener del usuario, intentar desde sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                // Si la reserva ya tiene IDAdministrador asignado, usarlo
                if (nueva.IDAdministrador > 0)
                {
                    idAdministrador = nueva.IDAdministrador;
                }

                if (!idAdministrador.HasValue)
                {
                    throw new Exception("No se puede determinar el administrador para la reserva.");
                }

                datos.SetearConsulta("INSERT INTO RESERVAS (IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva, IDAdministrador) " +
                                     "VALUES (@IDUsuario, @FechaReserva, @FechaVencimientoReserva, @MontoSeña, @EstadoReserva, @IDAdministrador); SELECT SCOPE_IDENTITY();");
                datos.SetearParametro("@IDUsuario", nueva.IdUsuario.IdUsuario);
                datos.SetearParametro("@FechaReserva", nueva.FechaReserva);
                datos.SetearParametro("@FechaVencimientoReserva", nueva.FechaVencimiento);
                datos.SetearParametro("@MontoSeña", nueva.MontoSeña);
                datos.SetearParametro("@EstadoReserva", nueva.EstadoReserva);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);

                object result = datos.EjecutarAccionScalar();
                return Convert.ToInt32(result);
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
        public void ActualizarEstado(int idReserva, bool estado)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("UPDATE RESERVAS SET EstadoReserva = @Estado WHERE IDReserva = @IDReserva");
                datos.SetearParametro("@Estado", estado);
                datos.SetearParametro("@IDReserva", idReserva);
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
        public void ModificarReserva(Reserva reserva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE RESERVAS SET IDUsuario=@IDUsuario, FechaReserva=@FechaReserva, FechaVencimientoReserva=@FechaVencimientoReserva, " +
                                     "MontoSeña=@MontoSeña, EstadoReserva=@EstadoReserva WHERE IDReserva=@IDReserva");
                datos.SetearParametro("@IDReserva", reserva.IdReserva);
                datos.SetearParametro("@IDUsuario", reserva.IdUsuario.IdUsuario);
                datos.SetearParametro("@FechaReserva", reserva.FechaReserva);
                datos.SetearParametro("@FechaVencimientoReserva", reserva.FechaVencimiento);
                datos.SetearParametro("@MontoSeña", reserva.MontoSeña);
                datos.SetearParametro("@EstadoReserva", reserva.EstadoReserva);

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

        public void EliminarReserva(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM RESERVAS WHERE IDReserva=@IDReserva");
                datos.SetearParametro("@IDReserva", id);
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

        public Reserva ObtenerPorId(int idReserva)
        {
            Reserva reserva = null;
            AccesoDatos datos = new AccesoDatos();

            try
            {
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                string whereClause = "WHERE IDReserva = @IDReserva";

                // Si hay un administrador en sesión, validar que la reserva le pertenece
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT IDReserva, IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva, IDAdministrador FROM RESERVAS " + whereClause);
                datos.SetearParametro("@IDReserva", idReserva);

                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }

                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    reserva = new Reserva();
                    reserva.IdReserva = (int)datos.Lector["IDReserva"];
                    reserva.IdUsuario = new Usuario { IdUsuario = (int)datos.Lector["IDUsuario"] };
                    reserva.FechaReserva = (DateTime)datos.Lector["FechaReserva"];
                    reserva.FechaVencimiento = (DateTime)datos.Lector["FechaVencimientoReserva"];
                    reserva.MontoSeña = (decimal)datos.Lector["MontoSeña"];
                    reserva.EstadoReserva = (bool)datos.Lector["EstadoReserva"];
                    reserva.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    reserva.IdUsuario = usuarioNegocio.ObtenerPorId(reserva.IdUsuario.IdUsuario);
                }

                return reserva;
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

        public Reserva ObtenerReservaPorArticulo(int idArticulo)
        {
            Reserva reserva = null;
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta(@"
                    SELECT TOP 1
                        r.IDReserva,
                        r.IDUsuario,
                        r.FechaReserva,
                        r.FechaVencimientoReserva,
                        r.MontoSeña,
                        r.EstadoReserva
                    FROM RESERVAS r
                    INNER JOIN ARTICULOSXRESERVA ar ON r.IDReserva = ar.IDReserva
                    WHERE ar.IDArticulo = @IDArticulo
                    ORDER BY r.FechaReserva DESC");

                datos.SetearParametro("@IDArticulo", idArticulo);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    reserva = new Reserva();
                    reserva.IdReserva = (int)datos.Lector["IDReserva"];
                    reserva.IdUsuario = new Usuario { IdUsuario = (int)datos.Lector["IDUsuario"] };
                    reserva.FechaReserva = (DateTime)datos.Lector["FechaReserva"];
                    reserva.FechaVencimiento = (DateTime)datos.Lector["FechaVencimientoReserva"];
                    reserva.MontoSeña = (decimal)datos.Lector["MontoSeña"];
                    reserva.EstadoReserva = (bool)datos.Lector["EstadoReserva"];

                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    reserva.IdUsuario = usuarioNegocio.ObtenerPorId(reserva.IdUsuario.IdUsuario);
                }

                return reserva;
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

        public int AgregarReservaConArticulos(Reserva reserva, List<Articulo> articulos)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Obtener IDAdministrador del primer artículo o del usuario
                int? idAdministrador = null;

                // Si hay artículos, obtener IDAdministrador del primero
                if (articulos != null && articulos.Count > 0 && articulos[0].IDAdministrador > 0)
                {
                    idAdministrador = articulos[0].IDAdministrador;
                }

                // Si no, obtener del usuario que hace la reserva
                if (!idAdministrador.HasValue && reserva.IdUsuario != null && reserva.IdUsuario.IdUsuario > 0)
                {
                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    Usuario usuario = usuarioNegocio.ObtenerPorId(reserva.IdUsuario.IdUsuario);
                    if (usuario != null)
                    {
                        idAdministrador = usuario.IDAdministrador;
                    }
                }

                // Si la reserva ya tiene IDAdministrador asignado, usarlo
                if (reserva.IDAdministrador > 0)
                {
                    idAdministrador = reserva.IDAdministrador;
                }

                // Si no se pudo obtener, intentar desde sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                if (!idAdministrador.HasValue)
                {
                    throw new Exception("No se puede determinar el administrador para la reserva.");
                }

                // 1) Insertar la reserva y obtener ID generado
                datos.SetearConsulta(@"
            INSERT INTO RESERVAS 
            (IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva, IDAdministrador)
            VALUES 
            (@IDUsuario, @FechaReserva, @FechaVencimiento, @MontoSeña, @EstadoReserva, @IDAdministrador);
            SELECT SCOPE_IDENTITY();");

                datos.SetearParametro("@IDUsuario", reserva.IdUsuario.IdUsuario);
                datos.SetearParametro("@FechaReserva", reserva.FechaReserva);
                datos.SetearParametro("@FechaVencimiento", reserva.FechaVencimiento);
                datos.SetearParametro("@MontoSeña", reserva.MontoSeña);
                datos.SetearParametro("@EstadoReserva", reserva.EstadoReserva);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);

                object result = datos.EjecutarAccionScalar();
                int idReserva = Convert.ToInt32(result);

                datos.cerrarConexion();

                // 2) Insertar artículos asociados a la reserva
                foreach (var art in articulos)
                {
                    datos = new AccesoDatos();
                    datos.SetearConsulta(@"
                INSERT INTO ARTICULOSXRESERVA (IDReserva, IDArticulo)
                VALUES (@IDReserva, @IDArticulo)");

                    datos.SetearParametro("@IDReserva", idReserva);
                    datos.SetearParametro("@IDArticulo", art.IdArticulo);

                    datos.EjecutarAccion();
                    datos.cerrarConexion();
                }

                return idReserva;
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

        public void ConfirmarPagoSeña(int idReserva, string comprobante)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta(@"
            UPDATE RESERVAS
            SET EstadoReserva = 2, 
                Comprobante = @comprobante,
                FechaComprobante = GETDATE()
            WHERE IDReserva = @id
        ");

                datos.SetearParametro("@id", idReserva);
                datos.SetearParametro("@comprobante", (object)comprobante ?? DBNull.Value);

                datos.EjecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}