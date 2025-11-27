<%@ Page Title="Panel de Usuario" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="PanelUsuario.aspx.cs" Inherits="APP_Web_Equipo10A.PanelUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reservations-container {
            min-height: 100vh;
            background-color: var(--background-light);
            display: flex;
            flex: 1;
            justify-content: center;
            padding: 1.25rem 0;
        }

        .reservations-content {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 80rem;
            flex: 1;
        }

        /* HEADER */
        .reservations-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            white-space: nowrap;
            border-bottom: 1px solid #e2e8f0;
            padding: 0.75rem 1rem;
            background-color: white;
            border-radius: 0.75rem 0.75rem 0 0;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: #1e293b;
        }

        .brand-icon {
            width: 1.5rem;
            height: 1.5rem;
            color: var(--primary-color);
        }

        .brand-title {
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.015em;
        }

        .header-actions {
            display: flex;
            flex: 1;
            justify-content: flex-end;
            gap: 1rem;
            align-items: center;
        }

        .header-links {
            display: none;
            align-items: center;
            gap: 2.25rem;
        }

        @media (min-width: 640px) {
            .header-links {
                display: flex;
            }
        }

        .header-link {
            color: #1e293b;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
        }

            .header-link:hover {
                color: var(--primary-color);
            }

        .user-avatar {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            aspect-ratio: 1;
            border-radius: 50%;
            width: 2.5rem;
            height: 2.5rem;
        }

        /* MAIN CONTENT */
        .main-content {
            background-color: white;
            border-radius: 0 0 0.75rem 0.75rem;
            flex-grow: 1;
            padding: 1rem;
        }

        @media (min-width: 1024px) {
            .main-content {
                padding: 2rem;
            }
        }

        .page-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            padding: 1rem;
        }

        .page-title {
            color: #0f172a;
            font-size: 2.25rem;
            font-weight: 900;
            letter-spacing: -0.033em;
        }

        .page-subtitle {
            color: #64748b;
        }
        /* TABS */
        .tabs-container {
            padding: 0 1rem 0.75rem;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #cbd5e1;
            gap: 2rem;
            overflow-x: auto;
        }

        .tab {
            padding: 1rem 0 0.8125rem;
            color: #64748b;
            border-bottom: 3px solid transparent;
        }

            .tab.active {
                border-bottom-color: var(--primary-color);
                color: #0f172a;
            }

        /* RESERVAS */
        .reservation-card {
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            background-color: var(--background-light);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .item-card {
            background-color: white;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            padding: 1rem;
            display: flex;
            gap: 1rem;
        }

        .item-image {
            width: 6rem;
            height: 6rem;
            object-fit: cover;
            border-radius: 0.375rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="reservations-container">
        <div class="reservations-content">

            <!-- MAIN -->
            <main class="main-content">
                <!-- TITULO -->
                <div class="page-header">
                    <div>
                        <p class="page-title">Panel de Usuario</p>
                        <p class="page-subtitle">Gestiona tus reservas y compras.</p>
                    </div>
                </div>

                <!-- TABS -->
                <div class="tabs-container">
                    <div class="tabs">
                        <a class="tab active" href="#">Reservas Activas</a>
                        <a class="tab" href="#">Completadas</a>
                        <a class="tab" href="#">Vencidas</a>
                    </div>
                </div>

                <!-- LISTADO DE RESERVAS -->
                <div class="reservations-list">

                    <asp:Repeater ID="rptReservas" runat="server">
                        <ItemTemplate>
                            <div class="reservation-card">
                                <!-- ENCABEZADO -->
                                <div class="reservation-header">
                                    <div class="reservation-info">
                                        <h3>Reserva #<%# Eval("IdReserva") %></h3>
                                        <p>Generada el <%# Eval("FechaReserva","{0:dd/MM/yyyy}") %></p>
                                    </div>

                                    <div class='countdown <%# GetCountdownColor((DateTime)Eval("FechaVencimiento")) %>'>
                                        <p>Vence en:</p>
                                        <p><%# ObtenerTiempoRestante((DateTime)Eval("FechaVencimiento")) %></p>
                                    </div>
                                </div>
                            </div>
                            <!-- ADMIN -->
                            <div class="contact-section">
                                <h4 class="contact-title">Administrador</h4>
                                <p><b><%# Eval("Administrador.Nombre") %> <%# Eval("Administrador.Apellido") %></b></p>
                                <p><%# Eval("Administrador.Email") %></p>
                            </div>
                            <!-- ARTÍCULOS -->
                            <div class="items-section">
                                <h4>Artículos reservados</h4>

                                <asp:Repeater ID="rptArticulos" runat="server" DataSource='<%# Eval("ArticulosReservados") %>'>
                                    <ItemTemplate>

                                        <div class="item-card">

                                            <img class="item-image"
                                                src='<%# ((List<Dominio.Imagen>)Eval("Imagenes")).Count > 0 
                            ? ((List<Dominio.Imagen>)Eval("Imagenes"))[0].RutaImagen 
                            : "/Images/no-image.png" %>' />

                                            <div class="item-details">
                                                <p class="item-name"><%# Eval("Nombre") %></p>

                                                <p class="item-description" style="font-size: 0.9rem; color: #64748b;">
                                                    <%# Eval("Descripcion") %>
                                                </p>
                                                <!-- PRECIO FORMATEADO -->
                                                <p>
                                                    Precio:
                       
                                                    <%# String.Format(
                                System.Globalization.CultureInfo.GetCultureInfo("es-AR"),
                                "{0:C2}",
                                Eval("Precio")
                            ) %>
                                                </p>

                                                <!-- SEÑA FORMATEADA -->
                                                <p>
                                                    Seña:
                       
                                                    <%# String.Format(
                                System.Globalization.CultureInfo.GetCultureInfo("es-AR"),
                                "{0:C2}",
                                Convert.ToDecimal(Eval("Precio")) * 0.10m
                            ) %>
                                                </p>

                                                <!-- RESTANTE FORMATEADO -->
                                                <p>
                                                    Restante:
                       
                                                    <%# String.Format(
                                System.Globalization.CultureInfo.GetCultureInfo("es-AR"),
                                "{0:C2}",
                                Convert.ToDecimal(Eval("Precio")) * 0.90m
                            ) %>
                                                </p>
                                            </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </main>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>


