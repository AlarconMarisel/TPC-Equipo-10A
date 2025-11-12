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
    public partial class Default : System.Web.UI.Page
    {
        private const int ARTICULOS_POR_PAGINA = 16; // 4 filas x 4 columnas
        private const int ARTICULOS_MAS_CAROS = 4;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
                CargarTePuedeInteresar(); // Siempre cargar "Te puede Interesar"
                
                var categoriaId = Request.QueryString["categoria"];
                if (!string.IsNullOrEmpty(categoriaId) && int.TryParse(categoriaId, out int idCategoria))
                {
                    ddlCategoria.SelectedValue = idCategoria.ToString();
                    int pagina = 1;
                    int.TryParse(Request.QueryString["pagina"], out pagina);
                    FiltrarPorCategoria(idCategoria, pagina);
                }
                else
                {
                    var query = Request["q"];
                    if (!string.IsNullOrWhiteSpace(query))
                    {
                        txtBusqueda.Text = query;
                        int pagina = 1;
                        int.TryParse(Request.QueryString["pagina"], out pagina);
                        BuscarArticulos(query, pagina);
                    }
                    else
                    {
                        int pagina = 1;
                        int.TryParse(Request.QueryString["pagina"], out pagina);
                        CargarArticulosRecientes(pagina);
                    }
                }
            }
            else
            {
                if (ddlCategoria.Items.Count == 0)
                {
                    CargarCategorias();
                }
                CargarTePuedeInteresar(); // Siempre cargar "Te puede Interesar"
            }
        }

        private void CargarTodosLosArticulos()
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var articulos = negocio.listarArticulo();

                if (articulos != null && articulos.Count > 0)
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = $"<p class='text-muted mb-3'>Mostrando {articulos.Count} artículos disponibles</p>";
                    rptResultados.DataSource = articulos;
                    rptResultados.DataBind();
                }
                else
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = "<p class='text-muted mb-3'>No hay artículos disponibles por el momento.</p>";
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class='text-danger'>Error al cargar artículos: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }


        private void BuscarArticulos(string query, int pagina = 1)
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var todosLosArticulos = negocio.listarArticulo();

                var filtrados = todosLosArticulos
                    .Where(a =>
                        (a.Nombre ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                        (a.Descripcion ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                        (a.CategoriaArticulo?.Nombre ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0)
                    .ToList();

                int totalArticulos = filtrados.Count;
                int totalPaginas = (int)Math.Ceiling((double)totalArticulos / ARTICULOS_POR_PAGINA);
                
                var articulosPaginados = filtrados
                    .Skip((pagina - 1) * ARTICULOS_POR_PAGINA)
                    .Take(ARTICULOS_POR_PAGINA)
                    .ToList();

                pnlResultados.Visible = true;
                litResumen.Text = $"<p class=\"text-muted mb-3\">Se encontraron {totalArticulos} resultado(s) para \"{Server.HtmlEncode(query)}\"</p>";
                rptResultados.DataSource = articulosPaginados;
                rptResultados.DataBind();

                // Configurar paginación
                if (totalPaginas > 1)
                {
                    ConfigurarPaginacion(pagina, totalPaginas, query: query);
                }
                else
                {
                    pnlPaginacion.Visible = false;
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class=\"text-danger\">Error al buscar: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }

        private void CargarArticulosRecientes(int pagina = 1)
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var todosLosArticulos = negocio.listarArticulo();

                int totalArticulos = todosLosArticulos.Count;
                int totalPaginas = (int)Math.Ceiling((double)totalArticulos / ARTICULOS_POR_PAGINA);
                
                var articulosPaginados = todosLosArticulos
                    .Skip((pagina - 1) * ARTICULOS_POR_PAGINA)
                    .Take(ARTICULOS_POR_PAGINA)
                    .ToList();

                if (articulosPaginados.Count > 0)
                {
                    rptResultados.DataSource = articulosPaginados;
                    rptResultados.DataBind();
                    pnlResultados.Visible = true;
                    litResumen.Text = $"<p class='text-muted mb-3'>Mostrando los artículos más recientes ({totalArticulos} total)</p>";
                }
                else
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = "<p class='text-muted'>No hay artículos disponibles.</p>";
                }

                // Configurar paginación
                if (totalPaginas > 1)
                {
                    ConfigurarPaginacion(pagina, totalPaginas);
                }
                else
                {
                    pnlPaginacion.Visible = false;
                }
            }
            catch (Exception ex)
            {
                pnlResultados.Visible = true;
                litResumen.Text = $"<p class='text-danger'>Error al cargar artículos: {Server.HtmlEncode(ex.Message)}</p>";
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var q = (txtBusqueda.Text ?? string.Empty).Trim();
            if (string.IsNullOrEmpty(q))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            Response.Redirect("Default.aspx?q=" + Server.UrlEncode(q), false);
        }

        private void CargarCategorias()
        {
            try
            {
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                var categorias = categoriaNegocio.ListarCategorias();

                ddlCategoria.DataSource = categorias;
                ddlCategoria.DataTextField = "Nombre";
                ddlCategoria.DataValueField = "IdCategoria";
                ddlCategoria.DataBind();
                
                ListItem itemTodas = new ListItem("Todas las categorías", "0");
                itemTodas.Selected = true;
                ddlCategoria.Items.Insert(0, itemTodas);
                
                ddlCategoria.SelectedIndex = 0;
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string selectedValue = ddlCategoria.SelectedValue;
                
                if (selectedValue == "0" || string.IsNullOrEmpty(selectedValue))
                {
                    CargarArticulosRecientes(1);
                }
                else
                {
                    int idCategoria = int.Parse(selectedValue);
                    FiltrarPorCategoria(idCategoria, 1);
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class='text-danger'>Error al filtrar por categoría: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }

        private void FiltrarPorCategoria(int idCategoria, int pagina = 1)
        {
            try
            {
                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                var todosLosArticulos = articuloNegocio.ListarConFiltrosYPaginacion(1, 10000, null, idCategoria, null);
                
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                var categoria = categoriaNegocio.ObtenerPorId(idCategoria);
                string nombreCategoria = categoria != null ? categoria.Nombre : "categoría seleccionada";

                int totalArticulos = todosLosArticulos.Count;
                int totalPaginas = (int)Math.Ceiling((double)totalArticulos / ARTICULOS_POR_PAGINA);
                
                var articulosPaginados = todosLosArticulos
                    .Skip((pagina - 1) * ARTICULOS_POR_PAGINA)
                    .Take(ARTICULOS_POR_PAGINA)
                    .ToList();

                if (articulosPaginados != null && articulosPaginados.Count > 0)
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = $"<p class='text-muted mb-3'>Mostrando {totalArticulos} artículo(s) en la categoría <strong>{Server.HtmlEncode(nombreCategoria)}</strong></p>";
                    rptResultados.DataSource = articulosPaginados;
                    rptResultados.DataBind();
                }
                else
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = $"<p class='text-muted mb-3'>No hay artículos disponibles en la categoría <strong>{Server.HtmlEncode(nombreCategoria)}</strong>.</p>";
                    rptResultados.DataSource = null;
                    rptResultados.DataBind();
                }

                // Configurar paginación
                if (totalPaginas > 1)
                {
                    ConfigurarPaginacion(pagina, totalPaginas, idCategoria: idCategoria);
                }
                else
                {
                    pnlPaginacion.Visible = false;
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class='text-danger'>Error al filtrar artículos: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }

        private void CargarTePuedeInteresar()
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var todosLosArticulos = negocio.listarArticulo();

                var articulosMasCaros = todosLosArticulos
                    .OrderByDescending(a => a.Precio)
                    .Take(ARTICULOS_MAS_CAROS)
                    .ToList();

                if (articulosMasCaros.Count > 0)
                {
                    rptTePuedeInteresar.DataSource = articulosMasCaros;
                    rptTePuedeInteresar.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Error al cargar artículos más caros - se ignora silenciosamente
            }
        }

        private void ConfigurarPaginacion(int paginaActual, int totalPaginas, string query = null, int? idCategoria = null)
        {
            try
            {
                var paginas = new List<dynamic>();
                
                for (int i = 1; i <= totalPaginas; i++)
                {
                    paginas.Add(new { NumeroPagina = i, EsActiva = (i == paginaActual) });
                }

                rptPaginacion.DataSource = paginas;
                rptPaginacion.DataBind();
                pnlPaginacion.Visible = true;

                // Guardar parámetros en ViewState para usar en el evento de paginación
                ViewState["Query"] = query;
                ViewState["IdCategoria"] = idCategoria;
            }
            catch (Exception ex)
            {
                pnlPaginacion.Visible = false;
            }
        }

        protected void lnkPagina_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnk = (LinkButton)sender;
                int pagina = int.Parse(lnk.CommandArgument);

                string query = ViewState["Query"] as string;
                int? idCategoria = ViewState["IdCategoria"] as int?;

                if (idCategoria.HasValue)
                {
                    ddlCategoria.SelectedValue = idCategoria.Value.ToString();
                    FiltrarPorCategoria(idCategoria.Value, pagina);
                }
                else if (!string.IsNullOrEmpty(query))
                {
                    txtBusqueda.Text = query;
                    BuscarArticulos(query, pagina);
                }
                else
                {
                    CargarArticulosRecientes(pagina);
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class='text-danger'>Error al cambiar de página: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }
    }
}
