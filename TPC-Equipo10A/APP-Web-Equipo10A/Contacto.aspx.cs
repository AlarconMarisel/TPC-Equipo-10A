using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace APP_Web_Equipo10A
{
    public partial class Contacto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Visible = false;
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            try
            {
                // Aquí se podría implementar el envío del email o guardar en base de datos
                // Por ahora solo mostramos un mensaje de confirmación
                
                string nombre = txtNombre.Text;
                string email = txtEmail.Text;
                string asunto = ddlAsunto.SelectedValue;
                string mensaje = txtMensaje.Text;

                // Validación básica
                if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mensaje))
                {
                    lblMensaje.Text = "Por favor completa todos los campos obligatorios.";
                    lblMensaje.CssClass = "text-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Simulación de envío exitoso
                // TODO: Implementar envío real de email o guardado en BD
                
                lblMensaje.Text = "¡Gracias por contactarnos! Hemos recibido tu mensaje y te responderemos pronto.";
                lblMensaje.CssClass = "text-success fw-semibold";
                lblMensaje.Visible = true;

                // Limpiar formulario
                txtNombre.Text = "";
                txtEmail.Text = "";
                txtTelefono.Text = "";
                txtMensaje.Text = "";
                ddlAsunto.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al enviar el mensaje. Por favor intenta nuevamente.";
                lblMensaje.CssClass = "text-danger";
                lblMensaje.Visible = true;
            }
        }
    }
}


