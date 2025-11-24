using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class PanelAdministrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Valida acceso de administrador
                if (!ValidarAccesoAdministrador())
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Carga resumen de la tienda
                CargarResumenTienda();
            }
        }

        /// <summary>
        /// Valida que el usuario es administrador activo y no vencido
        /// </summary>
        private bool ValidarAccesoAdministrador()
        {
            if (!ValidacionHelper.ValidarEsAdministradorActivo())
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();
                if (usuario != null && usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (!usuario.Activo)
                    {
                        Response.Write("<script>alert('Su cuenta de administrador está inactiva. Contacte al super administrador.');</script>");
                    }
                    else if (usuario.FechaVencimiento.HasValue && usuario.FechaVencimiento.Value < DateTime.Now)
                    {
                        Response.Write("<script>alert('Su cuenta de administrador ha vencido. Contacte al super administrador.');</script>");
                    }
                }
                return false;
            }
            return true;
        }

        /// <summary>
        /// Carga el resumen de la tienda del administrador
        /// </summary>
        private void CargarResumenTienda()
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();

                // Debug temporal - verificar ID
                if (usuario != null)
                {
                    System.Diagnostics.Debug.WriteLine($"DEBUG PanelAdmin - Usuario ID: {usuario.IdUsuario}, Tipo: {usuario.Tipo}, IDAdministrador obtenido: {idAdministrador}");
                }

                if (!idAdministrador.HasValue)
                {
                    // Si no hay IDAdministrador, mostrar 0 en todo
                    lblCantidadArticulos.Text = "0";
                    lblCantidadCategorias.Text = "0";
                    lblCantidadReservas.Text = "0";
                    lblCantidadVentas.Text = "0";
                    lblReservasPendientes.Text = "0";
                    lblReservasPendientesTexto.Text = "0";
                    System.Diagnostics.Debug.WriteLine("DEBUG PanelAdmin - No se obtuvo IDAdministrador");
                    return;
                }

                System.Diagnostics.Debug.WriteLine($"DEBUG PanelAdmin - Consultando con IDAdministrador: {idAdministrador.Value}");

                // Obtiene estadisticas
                int cantidadArticulos = ObtenerCantidadArticulos(idAdministrador.Value);
                int cantidadCategorias = ObtenerCantidadCategorias(idAdministrador.Value);
                int cantidadReservasPendientes = ObtenerCantidadReservasPendientes(idAdministrador.Value);
                int cantidadVentasMes = ObtenerCantidadVentasMes(idAdministrador.Value);

                System.Diagnostics.Debug.WriteLine($"DEBUG PanelAdmin - Resultados: Artículos={cantidadArticulos}, Categorías={cantidadCategorias}, Reservas={cantidadReservasPendientes}, Ventas={cantidadVentasMes}");

                // Actualiza labels en la pagina
                lblCantidadArticulos.Text = cantidadArticulos.ToString();
                lblCantidadCategorias.Text = cantidadCategorias.ToString();
                lblCantidadReservas.Text = cantidadReservasPendientes.ToString();
                lblCantidadVentas.Text = cantidadVentasMes.ToString();
                
                // Actualiza tarjeta de accion urgente
                lblReservasPendientes.Text = cantidadReservasPendientes.ToString();
                lblReservasPendientesTexto.Text = cantidadReservasPendientes.ToString();
            }
            catch (Exception ex)
            {
                // Muestra error en la pagina para debugging
                System.Diagnostics.Debug.WriteLine("Error al cargar resumen: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                // Tambien muestra en consola del navegador
                Response.Write($"<script>console.error('Error al cargar resumen: {ex.Message}');</script>");
            }
        }

        /// <summary>
        /// Obtiene la cantidad de articulos activos del administrador
        /// </summary>
        private int ObtenerCantidadArticulos(int idAdministrador)
        {
            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                List<Articulo> articulos = negocio.listarArticulo(idAdministrador);
                int cantidad = articulos != null ? articulos.Count : 0;
                System.Diagnostics.Debug.WriteLine($"DEBUG ObtenerCantidadArticulos - IDAdmin: {idAdministrador}, Cantidad: {cantidad}");
                return cantidad;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener cantidad de artículos: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }
        }

        /// <summary>
        /// Obtiene la cantidad de categorias del administrador
        /// </summary>
        private int ObtenerCantidadCategorias(int idAdministrador)
        {
            try
            {
                CategoriaNegocio negocio = new CategoriaNegocio();
                List<Categoria> categorias = negocio.ListarCategorias(idAdministrador);
                int cantidad = categorias != null ? categorias.Count : 0;
                System.Diagnostics.Debug.WriteLine($"DEBUG ObtenerCantidadCategorias - IDAdmin: {idAdministrador}, Cantidad: {cantidad}");
                return cantidad;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener cantidad de categorías: " + ex.Message + " | StackTrace: " + ex.StackTrace);
                return 0;
            }
        }

        /// <summary>
        /// Obtiene la cantidad de reservas pendientes del administrador
        /// </summary>
        private int ObtenerCantidadReservasPendientes(int idAdministrador)
        {
            try
            {
                ReservaNegocio negocio = new ReservaNegocio();
                List<Reserva> reservas = negocio.ListarReservas(idAdministrador);
                // Filtra solo las pendientes (asumiendo que hay un estado)
                // Por ahora retornamos todas las reservas
                return reservas != null ? reservas.Count : 0;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener cantidad de reservas: " + ex.Message);
                return 0;
            }
        }

        /// <summary>
        /// Obtiene la cantidad de ventas del mes actual del administrador
        /// </summary>
        private int ObtenerCantidadVentasMes(int idAdministrador)
        {
            try
            {
                VentaNegocio negocio = new VentaNegocio();
                List<Venta> ventas = negocio.ListarVentas(idAdministrador);
                
                if (ventas == null)
                    return 0;
                
                // Filtra solo las del mes actual
                DateTime inicioMes = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                return ventas.Count(v => v.FechaVenta >= inicioMes);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener cantidad de ventas: " + ex.Message);
                return 0;
            }
        }
    }
}
