using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class VentaNegocio
    {
        public List<Venta> ListarVentas()
        {
            List<Venta> lista = new List<Venta>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT IDVenta, IDReserva, FechaVenta, PrecioFinal FROM VENTAS");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Venta aux = new Venta();
                    aux.IdVenta = (int)datos.Lector["IDVenta"];
                    aux.Reserva = new Reserva { IdReserva = (int)datos.Lector["IDReserva"] };
                    aux.FechaVenta = (DateTime)datos.Lector["FechaVenta"];
                    aux.MontoTotal = (decimal)datos.Lector["PrecioFinal"];
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

        public int AgregarVenta(Venta nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("INSERT INTO VENTAS (IDReserva, FechaVenta, PrecioFinal) VALUES (@IDReserva, @FechaVenta, @PrecioFinal); SELECT SCOPE_IDENTITY();");
                datos.SetearParametro("@IDReserva", nueva.Reserva.IdReserva);
                datos.SetearParametro("@FechaVenta", nueva.FechaVenta);
                datos.SetearParametro("@PrecioFinal", nueva.MontoTotal);

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

        public void ModificarVenta(Venta venta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE VENTAS SET IDReserva=@IDReserva, FechaVenta=@FechaVenta, PrecioFinal=@PrecioFinal WHERE IDVenta=@IDVenta");
                datos.SetearParametro("@IDVenta", venta.IdVenta);
                datos.SetearParametro("@IDReserva", venta.Reserva.IdReserva);
                datos.SetearParametro("@FechaVenta", venta.FechaVenta);
                datos.SetearParametro("@PrecioFinal", venta.MontoTotal);
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

        public void EliminarVenta(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM VENTAS WHERE IDVenta=@IDVenta");
                datos.SetearParametro("@IDVenta", id);
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

        public Venta ObtenerVentaPorArticulo(int idArticulo)
        {
            Venta venta = null;
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta(@"
                    SELECT TOP 1
                        v.IDVenta,
                        v.IDReserva,
                        v.FechaVenta,
                        v.PrecioFinal,
                        r.IDUsuario
                    FROM VENTAS v
                    INNER JOIN RESERVAS r ON v.IDReserva = r.IDReserva
                    INNER JOIN ARTICULOSXRESERVA ar ON r.IDReserva = ar.IDReserva
                    WHERE ar.IDArticulo = @IDArticulo
                    ORDER BY v.FechaVenta DESC");

                datos.SetearParametro("@IDArticulo", idArticulo);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    venta = new Venta();
                    venta.IdVenta = (int)datos.Lector["IDVenta"];
                    venta.FechaVenta = (DateTime)datos.Lector["FechaVenta"];
                    venta.MontoTotal = (decimal)datos.Lector["PrecioFinal"];
                    
                    venta.Reserva = new Reserva();
                    venta.Reserva.IdReserva = (int)datos.Lector["IDReserva"];
                    venta.Reserva.IdUsuario = new Usuario { IdUsuario = (int)datos.Lector["IDUsuario"] };

                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    venta.Reserva.IdUsuario = usuarioNegocio.ObtenerPorId(venta.Reserva.IdUsuario.IdUsuario);
                }

                return venta;
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