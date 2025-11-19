using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace APP_Web_Equipo10A
{
    public partial class AdminGestionArticulo : System.Web.UI.Page
    {
        private const int REGISTROS_POR_PAGINA = 10;

        protected int PaginaActual
        {
            get
            {
                if (ViewState["PaginaActual"] != null)
                    return (int)ViewState["PaginaActual"];
                return 1;
            }
            set
            {
                ViewState["PaginaActual"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarFiltros();
                
                string exito = Request.QueryString["exito"];
                if (!string.IsNullOrEmpty(exito))
                {
                    string mensaje = "";
                    switch (exito.ToLower())
                    {
                        case "creado":
                            mensaje = "El artículo se ha creado exitosamente.";
                            break;
                        case "editado":
                            mensaje = "El artículo se ha actualizado exitosamente.";
                            break;
                        case "eliminado":
                            mensaje = "El artículo se ha eliminado exitosamente.";
                            break;
                    }
                    if (!string.IsNullOrEmpty(mensaje))
                    {
                        MostrarExito(mensaje);
                    }
                }
            }
            CargarArticulos();
        }

        private void CargarFiltros()
        {
            try
            {
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                ddlCategoria.DataSource = categoriaNegocio.ListarCategorias();
                ddlCategoria.DataTextField = "Nombre";
                ddlCategoria.DataValueField = "IdCategoria";
                ddlCategoria.DataBind();
                ddlCategoria.Items.Insert(0, new ListItem("Todas las Categorías", "0"));

                EstadoNegocio estadoNegocio = new EstadoNegocio();
                ddlEstado.DataSource = estadoNegocio.ListarEstados();
                ddlEstado.DataTextField = "Nombre";
                ddlEstado.DataValueField = "IdEstado";
                ddlEstado.DataBind();
                ddlEstado.Items.Insert(0, new ListItem("Todos los Estados", "0"));
            }
            catch (Exception)
            {
                // Error al cargar filtros - se ignora silenciosamente
            }
        }

        private void CargarArticulos()
        {
            try
            {
                string criterio = string.IsNullOrWhiteSpace(txtBusqueda.Text) ? null : txtBusqueda.Text.Trim();
                
                int? idCategoria = null;
                if (ddlCategoria.SelectedValue != null && ddlCategoria.SelectedValue != "0")
                {
                    idCategoria = int.Parse(ddlCategoria.SelectedValue);
                }
                
                int? idEstado = null;
                if (ddlEstado.SelectedValue != null && ddlEstado.SelectedValue != "0")
                {
                    idEstado = int.Parse(ddlEstado.SelectedValue);
                }

                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                var articulos = articuloNegocio.ListarConFiltrosYPaginacion(PaginaActual, REGISTROS_POR_PAGINA, criterio, idCategoria, idEstado);
                int totalRegistros = articuloNegocio.ContarConFiltros(criterio, idCategoria, idEstado);

                if (articulos != null && articulos.Count > 0)
                {
                    repArticulos.DataSource = articulos;
                    repArticulos.DataBind();
                    lblSinArticulos.Visible = false;
                    repArticulos.Visible = true;
                }
                else
                {
                    repArticulos.Visible = false;
                    lblSinArticulos.Visible = true;
                }

                ConfigurarPaginacion(totalRegistros);
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar artículos: " + ex.Message);
                lblSinArticulos.Text = "<tr><td colspan='6' class='text-center text-muted' style='padding: 2rem;'>No se pudieron cargar los artículos.</td></tr>";
                lblSinArticulos.Visible = true;
                repArticulos.Visible = false;
            }
        }

        private void ConfigurarPaginacion(int totalRegistros)
        {
            int totalPaginas = (int)Math.Ceiling((double)totalRegistros / REGISTROS_POR_PAGINA);

            if (totalPaginas <= 1)
            {
                pnlPaginacion.Visible = false;
                lblInfoPaginacion.Visible = false;
                return;
            }

            pnlPaginacion.Visible = true;
            lblInfoPaginacion.Visible = true;

            int inicio = (PaginaActual - 1) * REGISTROS_POR_PAGINA + 1;
            int fin = Math.Min(PaginaActual * REGISTROS_POR_PAGINA, totalRegistros);
            lblInfoPaginacion.Text = $"Mostrando {inicio} - {fin} de {totalRegistros} artículos";

            lnkAnterior.Enabled = PaginaActual > 1;
            lnkSiguiente.Enabled = PaginaActual < totalPaginas;

            List<object> paginas = new List<object>();
            int inicioRango = Math.Max(1, PaginaActual - 2);
            int finRango = Math.Min(totalPaginas, PaginaActual + 2);

            if (inicioRango > 1)
            {
                paginas.Add(new { Numero = 1 });
                if (inicioRango > 2)
                {
                    paginas.Add(new { Numero = -1 });
                }
            }

            for (int i = inicioRango; i <= finRango; i++)
            {
                paginas.Add(new { Numero = i });
            }

            if (finRango < totalPaginas)
            {
                if (finRango < totalPaginas - 1)
                {
                    paginas.Add(new { Numero = -1 });
                }
                paginas.Add(new { Numero = totalPaginas });
            }

            repPaginacion.DataSource = paginas;
            repPaginacion.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                PaginaActual = 1;
                CargarArticulos();
            }
            catch (Exception ex)
            {
                MostrarError("Error al buscar: " + ex.Message);
                CargarArticulos();
            }
        }

        protected void Filtros_Changed(object sender, EventArgs e)
        {
            try
            {
                PaginaActual = 1;
                CargarArticulos();
            }
            catch (Exception ex)
            {
                MostrarError("Error al filtrar: " + ex.Message);
                CargarArticulos();
            }
        }

        protected void lnkPagina_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int numero = int.Parse(lnk.CommandArgument);
            if (numero > 0)
            {
                PaginaActual = numero;
                CargarArticulos();
            }
        }

        protected void lnkAnterior_Click(object sender, EventArgs e)
        {
            if (PaginaActual > 1)
            {
                PaginaActual--;
                CargarArticulos();
            }
        }

        protected void lnkSiguiente_Click(object sender, EventArgs e)
        {
            PaginaActual++;
            CargarArticulos();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idArticulo = int.Parse(btn.CommandArgument);

                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                articuloNegocio.Eliminar(idArticulo);

                // Redirigir con mensaje de éxito
                Response.Redirect("AdminGestionArticulo.aspx?exito=eliminado", false);
            }
            catch (Exception ex)
            {
                MostrarError("Error al eliminar el artículo: " + ex.Message);
                CargarArticulos();
            }
        }

        protected string GetImagenUrl(object dataItem)
        {
            if (dataItem is Dominio.Articulo articulo)
            {
                if (articulo.Imagenes != null && articulo.Imagenes.Count > 0 && !string.IsNullOrEmpty(articulo.Imagenes[0].RutaImagen))
                {
                    return ResolveUrl(articulo.Imagenes[0].RutaImagen);
                }
            }
            return "https://via.placeholder.com/100?text=Sin+Imagen";
        }

        protected string GetEstadoClass(object dataItem)
        {
            if (dataItem is Dominio.Articulo articulo)
            {
                string estadoNombre = articulo.EstadoArticulo?.Nombre?.ToLower() ?? "";
                
                if (estadoNombre.Contains("reservado") || estadoNombre.Contains("reserva"))
                {
                    return "status-reserved";
                }
                else if (estadoNombre.Contains("vendido") || estadoNombre.Contains("venta"))
                {
                    return "status-sold";
                }
            }
            return "status-available";
        }

        protected void repPaginacion_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var numero = ((dynamic)e.Item.DataItem).Numero;
                LinkButton lnk = (LinkButton)e.Item.FindControl("lnkPagina");
                Literal lit = (Literal)e.Item.FindControl("litElipsis");

                if (numero == -1)
                {
                    if (lnk != null) lnk.Visible = false;
                    if (lit != null) lit.Visible = true;
                }
                else
                {
                    if (lnk != null)
                    {
                        lnk.Visible = true;
                        lnk.Text = numero.ToString();
                        if (numero == PaginaActual)
                        {
                            lnk.CssClass = "pagination-link active";
                        }
                    }
                    if (lit != null) lit.Visible = false;
                }
            }
        }

        private void MostrarError(string mensaje)
        {
            string script = $@"
                <div id='mensajeError' style='position: fixed; top: 1rem; right: 1rem; z-index: 9999; padding: 1rem 1.5rem; background-color: #fee; border: 1px solid #fcc; border-radius: 0.5rem; color: #c33; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 400px;'>
                    <strong>Error:</strong> {Server.HtmlEncode(mensaje)}
                    <button onclick='document.getElementById(""mensajeError"").remove()' style='float: right; background: none; border: none; color: #c33; font-size: 1.2rem; cursor: pointer; margin-left: 1rem;'>&times;</button>
                </div>
                <script>
                    setTimeout(function() {{
                        var el = document.getElementById('mensajeError');
                        if (el) el.remove();
                    }}, 5000);
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", script, false);
        }

        private void MostrarExito(string mensaje)
        {

            string script = $@"
                <div id='mensajeExito' style='position: fixed; top: 1rem; right: 1rem; z-index: 9999; padding: 1rem 1.5rem; background-color: #efe; border: 1px solid #cfc; border-radius: 0.5rem; color: #3c3; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 400px;'>
                    <strong>Éxito:</strong> {Server.HtmlEncode(mensaje)}
                    <button onclick='document.getElementById(""mensajeExito"").remove()' style='float: right; background: none; border: none; color: #3c3; font-size: 1.2rem; cursor: pointer; margin-left: 1rem;'>&times;</button>
                </div>
                <script>
                    setTimeout(function() {{
                        var el = document.getElementById('mensajeExito');
                        if (el) el.remove();
                    }}, 5000);
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ExitoScript", script, false);
        }
    }
}
