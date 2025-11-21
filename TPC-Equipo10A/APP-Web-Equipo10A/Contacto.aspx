<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="APP_Web_Equipo10A.Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .contact-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }
        .contact-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 2.5rem;
        }
        .contact-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        .whatsapp-btn {
            background: #25D366;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        .whatsapp-btn:hover {
            background: #20BA5A;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 211, 102, 0.3);
            color: white;
            text-decoration: none;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="contact-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-5 fw-bold mb-3">Contáctanos</h1>
                    <p class="lead mb-0">Estamos aquí para ayudarte. Envíanos un mensaje y te responderemos lo antes posible.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="contact-card bg-white">
                        <h2 class="fw-bold mb-4">Envíanos un Mensaje</h2>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="txtNombre" class="form-label fw-semibold">Nombre Completo *</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Tu nombre" required></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtEmail" class="form-label fw-semibold">Email *</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="tu@email.com" required></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtTelefono" class="form-label fw-semibold">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="+54 9 11 1234-5678"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="ddlAsunto" class="form-label fw-semibold">Asunto *</label>
                                <asp:DropDownList ID="ddlAsunto" runat="server" CssClass="form-select" required>
                                    <asp:ListItem Value="" Text="Selecciona un asunto" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="consulta" Text="Consulta General"></asp:ListItem>
                                    <asp:ListItem Value="soporte" Text="Soporte Técnico"></asp:ListItem>
                                    <asp:ListItem Value="venta" Text="Información sobre Vender"></asp:ListItem>
                                    <asp:ListItem Value="compra" Text="Información sobre Comprar"></asp:ListItem>
                                    <asp:ListItem Value="problema" Text="Reportar un Problema"></asp:ListItem>
                                    <asp:ListItem Value="otro" Text="Otro"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12">
                                <label for="txtMensaje" class="form-label fw-semibold">Mensaje *</label>
                                <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="Escribe tu mensaje aquí..." required></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensaje" CssClass="btn btn-primary btn-lg rounded-pill px-5" OnClick="btnEnviar_Click" />
                                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-3" Visible="false"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="contact-card bg-white h-100">
                        <h3 class="fw-bold mb-4">Información de Contacto</h3>
                        
                        <div class="mb-4">
                            <div class="contact-icon">
                                <svg width="28" height="28" fill="white" viewBox="0 0 24 24">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/>
                                </svg>
                            </div>
                            <h5 class="fw-bold mb-2">WhatsApp</h5>
                            <p class="text-muted mb-3">Chatea con nosotros directamente</p>
                            <a href="https://wa.me/5491112345678" target="_blank" class="whatsapp-btn">
                                <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/>
                                </svg>
                                +54 9 11 1234-5678
                            </a>
                        </div>

                        <hr class="my-4">

                        <div class="mb-4">
                            <div class="contact-icon">
                                <span class="material-symbols-outlined text-white" style="font-size: 28px;">mail</span>
                            </div>
                            <h5 class="fw-bold mb-2">Email</h5>
                            <p class="text-muted mb-2">Escríbenos a:</p>
                            <a href="mailto:contacto@secondhand.com" class="text-decoration-none">contacto@secondhand.com</a>
                        </div>

                        <hr class="my-4">

                        <div>
                            <div class="contact-icon">
                                <span class="material-symbols-outlined text-white" style="font-size: 28px;">schedule</span>
                            </div>
                            <h5 class="fw-bold mb-2">Horario de Atención</h5>
                            <p class="text-muted mb-1"><strong>Lunes a Viernes:</strong> 9:00 - 18:00</p>
                            <p class="text-muted mb-1"><strong>Sábados:</strong> 10:00 - 14:00</p>
                            <p class="text-muted mb-0"><strong>Domingos:</strong> Cerrado</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

