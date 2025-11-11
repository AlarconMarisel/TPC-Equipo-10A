using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class AdminFormularioArticulo : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
           CategoriaNegocio categoriaNegocio = new CategoriaNegocio();

            try
            {
                if (!IsPostBack)
                {
                    ddlCategoria.DataSource = categoriaNegocio.ListarCategorias();
                    ddlCategoria.DataTextField = "Nombre";
                    ddlCategoria.DataValueField = "IdCategoria";
                    ddlCategoria.DataBind();
                    ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", "0"));
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores (puede ser un log o mostrar un mensaje)
                Console.WriteLine("Error al cargar las categorías: " + ex.Message);
            }
        }
    }
}


