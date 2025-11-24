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
        private const int ARTICULOS_POR_PAGINA = 16;
        private const int ARTICULOS_MAS_CAROS = 4;

        // IDAdministrador obtenido de la URL (si existe) o de la sesión
        private int? idAdministradorURL = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Obtener IDAdministrador desde la URL (Fase 5) - usando query string ?tienda=nombre
            idAdministradorURL = TenantHelper.ObtenerIDAdministradorDesdeURL();
            
            // Si no hay IDAdministrador en la URL, intentar obtenerlo de la sesión
            // (para usuarios normales que acceden directamente a Default.aspx)
            if (!idAdministradorURL.HasValue)
            {
                idAdministradorURL = TenantHelper.ObtenerIDAdministradorDesdeSesion();
            }
            
            // Configurar enlace de registro si hay tienda en la URL
            ConfigurarEnlaceRegistro();

            if (!IsPostBack)
            {
                CargarCategorias();
                CargarTePuedeInteresar();
                
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
                CargarTePuedeInteresar();
            }
        }

        private void CargarTodosLosArticulos()
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var articulos = negocio.listarArticulo(idAdministradorURL);

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
                var todosLosArticulos = negocio.listarArticulo(idAdministradorURL);

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
                var todosLosArticulos = negocio.listarArticulo(idAdministradorURL);

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
            string url = ConstruirURL("Default.aspx");
            
            if (string.IsNullOrEmpty(q))
            {
                Response.Redirect(url, false);
                return;
            }
            Response.Redirect(url + "?q=" + Server.UrlEncode(q), false);
        }

        /// <summary>
        /// Construye la URL manteniendo el contexto de la tienda si existe
        /// </summary>
        private string ConstruirURL(string pagina)
        {
            // Si hay un IDAdministrador de URL, mantener el contexto
            if (idAdministradorURL.HasValue)
            {
                // Intentar obtener el identificador desde HttpContext.Items (URL rewriting)
                string identificador = null;
                if (HttpContext.Current.Items.Contains("TiendaIdentificador"))
                {
                    identificador = HttpContext.Current.Items["TiendaIdentificador"] as string;
                }
                
                // Si no está en Items, intentar desde query string (fallback)
                if (string.IsNullOrWhiteSpace(identificador))
                {
                    identificador = Request.QueryString["tienda"];
                }
                
                // Si no está en Items ni en query string, intentar desde RawUrl
                if (string.IsNullOrWhiteSpace(identificador))
                {
                    string rawUrl = Request.RawUrl;
                    if (!string.IsNullOrWhiteSpace(rawUrl))
                    {
                        if (rawUrl.Contains("?"))
                            rawUrl = rawUrl.Split('?')[0];
                        if (rawUrl.StartsWith("/"))
                            rawUrl = rawUrl.Substring(1);
                        
                        if (!string.IsNullOrWhiteSpace(rawUrl) && !rawUrl.Contains(".aspx"))
                        {
                            identificador = rawUrl.Split('/')[0];
                        }
                    }
                }
                
                if (!string.IsNullOrWhiteSpace(identificador))
                {
                    // Construir URL con identificador: /identificador/pagina
                    return "/" + identificador + "/" + pagina;
                }
            }
            
            return pagina;
        }

        private void CargarCategorias()
        {
            try
            {
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                var categorias = categoriaNegocio.ListarCategorias(idAdministradorURL);

                // Si hay IDAdministrador, mostrar categorías de esa tienda
                // Si no hay IDAdministrador, solo mostrar "Todas las categorías" para evitar duplicados
                if (idAdministradorURL.HasValue)
                {
                    ddlCategoria.DataSource = categorias;
                    ddlCategoria.DataTextField = "Nombre";
                    ddlCategoria.DataValueField = "IdCategoria";
                    ddlCategoria.DataBind();
                    
                    ListItem itemTodas = new ListItem("Todas las categorías", "0");
                    itemTodas.Selected = true;
                    ddlCategoria.Items.Insert(0, itemTodas);
                    
                    ddlCategoria.SelectedIndex = 0;
                }
                else
                {
                    // Si no hay IDAdministrador, no mostrar categorías para evitar duplicados
                    ddlCategoria.Items.Clear();
                    ListItem itemTodas = new ListItem("Todas las categorías", "0");
                    itemTodas.Selected = true;
                    ddlCategoria.Items.Add(itemTodas);
                }
            }
            catch (Exception ex)
            {

            }
        }

        /// <summary>
        /// Configura el enlace de registro manteniendo el contexto de la tienda
        /// </summary>
        private void ConfigurarEnlaceRegistro()
        {
            // Mostrar enlace de registro solo si hay tienda en la URL y el usuario no está logueado
            Usuario usuario = Session["Usuario"] as Usuario;
            
            // Obtener identificador desde HttpContext.Items (URL rewriting) o query string
            string identificador = null;
            if (HttpContext.Current.Items.Contains("TiendaIdentificador"))
            {
                identificador = HttpContext.Current.Items["TiendaIdentificador"] as string;
            }
            
            if (string.IsNullOrWhiteSpace(identificador))
            {
                identificador = Request.QueryString["tienda"];
            }
            
            if (string.IsNullOrWhiteSpace(identificador))
            {
                // Intentar desde RawUrl
                string rawUrl = Request.RawUrl;
                if (!string.IsNullOrWhiteSpace(rawUrl))
                {
                    if (rawUrl.Contains("?"))
                        rawUrl = rawUrl.Split('?')[0];
                    if (rawUrl.StartsWith("/"))
                        rawUrl = rawUrl.Substring(1);
                    
                    if (!string.IsNullOrWhiteSpace(rawUrl) && !rawUrl.Contains(".aspx"))
                    {
                        identificador = rawUrl.Split('/')[0];
                    }
                }
            }
            
            if (!string.IsNullOrWhiteSpace(identificador) && usuario == null)
            {
                pnlRegistroTienda.Visible = true;
                // Construir URL con identificador: /identificador/Registro.aspx
                string urlRegistro = "/" + identificador + "/Registro.aspx";
                lnkRegistroTienda.NavigateUrl = urlRegistro;
            }
            else
            {
                pnlRegistroTienda.Visible = false;
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
                var todosLosArticulos = negocio.listarArticulo(idAdministradorURL);

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
