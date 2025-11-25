using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;

namespace Negocio
{
    public class EmailService
    {
        private MailMessage email;
        private SmtpClient server;

        public EmailService()
        {
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("89d4cca4fd5a6d", "1affce39d73386");
            server.Port = 2525;
            server.Host = "sandbox.smtp.mailtrap.io";
            server.EnableSsl = true;
        }
        public void ArmarEmail(string emailDestino, string asunto, string cuerpo)
        {
            email = new MailMessage();
            email.From = new MailAddress("noresponder@ecommerceprogramaciontp.com");
            email.To.Add(emailDestino);
            email.Subject = asunto;
            email.IsBodyHtml = true;
            email.Body = cuerpo;
        }

        public void EnviarEmail()
        {
            try
            {
                server.Send(email);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al enviar el correo: " + ex.Message);
            }
        }
    }
}
