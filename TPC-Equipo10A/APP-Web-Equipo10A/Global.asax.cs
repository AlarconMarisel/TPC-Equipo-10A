using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Text.RegularExpressions;

namespace APP_Web_Equipo10A
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            try
            {
                // URL Rewriting para soportar URLs personalizadas de tiendas (Fase 5)
                // Formato: /nombre-tienda o /admin-{ID}
                string rawUrl = Request.RawUrl;
                string path = Request.Path;
                
                // Convertir a minúsculas para comparación
                string pathLower = path.ToLower();
                
                // Ignorar archivos estáticos y recursos del sistema
                if (pathLower.Contains(".css") || 
                    pathLower.Contains(".js") || 
                    pathLower.Contains(".png") || 
                    pathLower.Contains(".jpg") || 
                    pathLower.Contains(".jpeg") || 
                    pathLower.Contains(".gif") || 
                    pathLower.Contains(".ico") ||
                    pathLower.Contains(".woff") ||
                    pathLower.Contains(".woff2") ||
                    pathLower.Contains(".ttf") ||
                    pathLower.Contains(".svg") ||
                    pathLower.StartsWith("/_") ||
                    pathLower.StartsWith("/content/") ||
                    pathLower.StartsWith("/scripts/") ||
                    pathLower.StartsWith("/uploads/") ||
                    pathLower.StartsWith("/app_data/"))
                {
                    return;
                }

                // Ignorar rutas de administración directas (pero NO admin-{ID} que es un identificador de tienda)
                // Verificar que no sea una ruta de administración real
                if (pathLower.StartsWith("/admin") && !pathLower.StartsWith("/admin-"))
                {
                    // Es una ruta de administración real (ej: /adminconfiguraciontienda.aspx)
                    return;
                }
                
                if (pathLower.StartsWith("/panel") ||
                    pathLower.StartsWith("/superadmin"))
                {
                    return;
                }

                // Si el path es una página ASPX directa (sin identificador), no hacer rewrite
                if (pathLower == "/" || 
                    pathLower == "/default.aspx" ||
                    pathLower == "/login.aspx" ||
                    pathLower == "/registro.aspx" ||
                    pathLower == "/carrito.aspx" ||
                    pathLower == "/detallearticulo.aspx")
                {
                    return;
                }

                // Si el path tiene .aspx pero solo una barra (página directa), no hacer rewrite
                if (pathLower.Contains(".aspx") && pathLower.Count(c => c == '/') <= 1)
                {
                    return;
                }

                // Analizar rawUrl para detectar identificador de tienda
                // Formato esperado: /identificador o /identificador/pagina.aspx
                string rawPath = rawUrl;
                int queryIndex = rawPath.IndexOf('?');
                if (queryIndex >= 0)
                {
                    rawPath = rawPath.Substring(0, queryIndex);
                }

                // Remover barra inicial
                if (rawPath.StartsWith("/"))
                {
                    rawPath = rawPath.Substring(1);
                }

                if (string.IsNullOrWhiteSpace(rawPath))
                {
                    return;
                }

                // Dividir en partes
                string[] partes = rawPath.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
                
                if (partes.Length == 0)
                {
                    return;
                }

                string primerSegmento = partes[0].ToLower();

                // Si el primer segmento es una página conocida, no hacer rewrite
                // PERO permitir admin-{ID} que es un identificador de tienda
                if (primerSegmento == "default.aspx" || 
                    primerSegmento == "login.aspx" || 
                    primerSegmento == "registro.aspx" ||
                    primerSegmento == "carrito.aspx" ||
                    primerSegmento == "detallearticulo.aspx" ||
                    primerSegmento.Contains("."))
                {
                    return;
                }
                
                // Ignorar rutas de administración reales (pero NO admin-{ID})
                if (primerSegmento.StartsWith("admin") && !primerSegmento.StartsWith("admin-"))
                {
                    // Es una ruta de administración real
                    return;
                }
                
                if (primerSegmento.StartsWith("panel") ||
                    primerSegmento.StartsWith("superadmin"))
                {
                    return;
                }

                // Es un identificador de tienda - guardarlo en HttpContext.Items
                Context.Items["TiendaIdentificador"] = partes[0]; // Guardar original (con mayúsculas)

                // Construir el path de rewrite
                string rewritePath;
                if (partes.Length > 1)
                {
                    // Hay página: /identificador/pagina.aspx
                    string pagina = partes[1];
                    if (!pagina.Contains("."))
                    {
                        pagina = pagina + ".aspx";
                    }
                    rewritePath = "/" + pagina;
                }
                else
                {
                    // Solo identificador: /identificador -> /Default.aspx
                    rewritePath = "/Default.aspx";
                }

                // Agregar query string si existe
                string queryString = Request.QueryString.ToString();
                if (!string.IsNullOrEmpty(queryString))
                {
                    rewritePath += "?" + queryString;
                }

                // Hacer el rewrite
                Context.RewritePath(rewritePath, false);
            }
            catch (Exception)
            {
                // Si hay cualquier error, no hacer rewrite
                return;
            }
        }
    }
}