<%@ Page Title="Detalle del Artículo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminDetalleArticulo.aspx.cs" Inherits="APP_Web_Equipo10A.AdminDetalleArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            flex-direction: row;
        }
        
        /* Sidebar */
        .sidebar {
            display: flex;
            height: 100vh;
            min-height: 100%;
            flex-direction: column;
            justify-content: space-between;
            background-color: white;
            padding: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 16rem;
            position: sticky;
            top: 0;
            flex-shrink: 0;
            z-index: 10;
        }
        
        .sidebar-header {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        
        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0 0.75rem;
        }
        
        .brand-logo {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            aspect-ratio: 1;
            border-radius: 50%;
            width: 2.5rem;
            height: 2.5rem;
        }
        
        .brand-info {
            display: flex;
            flex-direction: column;
        }
        
        .brand-title {
            color: #111827;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        .brand-subtitle {
            color: #111827;
            font-size: 1rem;
            font-weight: 700;
            line-height: 1.5;
        }
        
        .brand-tienda {
            color: #111827;
            font-size: 1.3rem;
            font-weight: 700;
            line-height: 1.5;
            margin-top: 0.25rem;
        }
        
        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .nav-link.active {
            background-color: rgba(17, 115, 212, 0.2);
            color: var(--primary-color);
        }
        
        .nav-link:not(.active) {
            color: #374151;
        }
        
        .nav-link:not(.active):hover {
            background-color: #f3f4f6;
        }
        
        .nav-icon {
            font-size: 1.25rem;
        }
        
        .nav-text {
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 2rem;
        }
        
        .content-wrapper {
            max-width: 80rem;
            margin: 0 auto;
        }
        
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .back-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background-color: white;
            border: 1px solid #cbd5e1;
            border-radius: 0.5rem;
            color: #374151;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .back-button:hover {
            background-color: #f8fafc;
        }
        
        .detail-container {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            width: 100%;
        }
        
        .detail-card {
            background-color: white;
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: 100%;
            box-sizing: border-box;
        }
        
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .image-gallery {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: center;
        }
        
        .main-image {
            width: 350px;
            max-width: 350px;
            height: 350px;
            border-radius: 0.5rem;
            object-fit: contain;
            background-color: #f8fafc;
            display: block;
            margin: 0 auto;
        }
        
        .thumbnail-container {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 0.5rem;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.2s ease;
        }
        
        .thumbnail:hover {
            border-color: var(--primary-color);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .info-label {
            font-size: 0.875rem;
            font-weight: 500;
            color: #64748b;
        }
        
        .info-value {
            font-size: 1rem;
            color: #1e293b;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            border-radius: 9999px;
            padding: 0.25rem 0.75rem;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .status-available {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .status-reserved {
            background-color: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }
        
        .status-sold {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .reservation-info, .sale-info {
            background-color: #f8fafc;
            padding: 1rem;
            border-radius: 0.5rem;
            border-left: 4px solid var(--primary-color);
        }
        
        .payment-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .payment-confirmed {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .payment-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #b45309;
        }
        
        .user-info-section {
            background-color: #f8fafc;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-top: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .admin-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                min-height: auto;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .main-image {
                width: 100%;
                max-width: 350px;
                height: auto;
                min-height: 250px;
            }
        }
        
        @media (min-width: 769px) {
            .admin-container {
                flex-direction: row;
            }
            
            .sidebar {
                width: 16rem;
                height: 100vh;
                position: sticky;
                top: 0;
                flex-shrink: 0;
            }
            
            .main-content {
                flex: 1;
                padding: 2rem;
                overflow-y: auto;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <!-- Brand -->
                <div class="sidebar-brand">
                    <div class="brand-logo" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBA4gRjXTuWhKZdQ1URmz9lIoHy7MDTi-nbylti6Lpi9VJc1vHf1Vcmo-tOmmWyp1fcfwOxHdkVEckj0bTlj-dxBmCRkbPxkT2lY759Ly4_Y7y4YPFKWWFpJlwCdcMqPv5YeNaaJUSNbiSsVXP0MVpnW_oTZJjYBBglUS-Fwtj-IYikT6VCJrElFGYbRb9ycQtiFGhTco22FhbzTrO1ryuHqoBLLKNm0sOCHG9mcBo-9gv403-NAQKluRS3QHfZ3PejbvaWti-ddgE");'></div>
                    <div class="brand-info">
                        <h1 class="brand-subtitle">Panel de Administrador</h1>
                        <asp:Label ID="lblNombreTienda" runat="server" CssClass="brand-tienda"></asp:Label>
                    </div>
                </div>
                
                <!-- Navigation -->
                <nav class="sidebar-nav">
                    <a class="nav-link" href="PanelAdministrador.aspx">
                        <span class="material-symbols-outlined nav-icon" style="font-variation-settings: 'FILL' 1;">dashboard</span>
                        <p class="nav-text">Dashboard</p>
                    </a>
                    <a class="nav-link active" href="AdminGestionArticulo.aspx">
                        <span class="material-symbols-outlined nav-icon">inventory_2</span>
                        <p class="nav-text">Artículos</p>
                    </a>
                    <a class="nav-link" href="AdminGestionCategoria.aspx">
                        <span class="material-symbols-outlined nav-icon">category</span>
                        <p class="nav-text">Categorías</p>
                    </a>
                    <a class="nav-link" href="AdminGestionReserva.aspx">
                        <span class="material-symbols-outlined nav-icon">receipt_long</span>
                        <p class="nav-text">Ventas</p>
                    </a>
                    <a class="nav-link" href="AdminGestionUsuario.aspx">
                        <span class="material-symbols-outlined nav-icon">group</span>
                        <p class="nav-text">Usuarios</p>
                    </a>
                    <a class="nav-link" href="AdminConfiguracionTienda.aspx">
                        <span class="material-symbols-outlined nav-icon">settings</span>
                        <p class="nav-text">Configuración</p>
                    </a>
                    <a class="nav-link" href="AdminMiPerfil.aspx">
                        <span class="material-symbols-outlined nav-icon">account_circle</span>
                        <p class="nav-text">Mi Perfil</p>
                    </a>
                </nav>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Detalle del Artículo</h1>
                    <a href="AdminGestionArticulo.aspx" class="back-button">
                        <span class="material-symbols-outlined">arrow_back</span>
                        Volver a Gestión
                    </a>
                </div>
                
                <!-- Detail Container -->
                <div class="detail-container">
                    <!-- Error Message -->
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="detail-card">
                        <div style="color: #dc3545; padding: 1rem;">
                            <asp:Label ID="lblError" runat="server" />
                        </div>
                    </asp:Panel>
                    
                    <!-- Article Images -->
                    <asp:Panel ID="pnlImagenes" runat="server" CssClass="detail-card">
                        <h2 class="card-title">Imágenes del Artículo</h2>
                        <div class="image-gallery">
                            <asp:Image ID="imgPrincipal" runat="server" CssClass="main-image" />
                            <div class="thumbnail-container">
                                <asp:Repeater ID="repThumbnails" runat="server">
                                    <ItemTemplate>
                                        <img src='<%# ResolveUrl(Eval("RutaImagen").ToString()) %>' 
                                             class="thumbnail" 
                                             onclick='document.getElementById("<%= imgPrincipal.ClientID %>").src = "<%# ResolveUrl(Eval("RutaImagen").ToString()) %>";' />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:Panel>
                    
                    <!-- Article General Info -->
                    <asp:Panel ID="pnlInfoGeneral" runat="server" CssClass="detail-card">
                        <h2 class="card-title">Información General</h2>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">Nombre</span>
                                <span class="info-value">
                                    <asp:Label ID="lblNombre" runat="server" />
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">ID</span>
                                <span class="info-value">
                                    <asp:Label ID="lblIdArticulo" runat="server" />
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Precio</span>
                                <span class="info-value">
                                    <asp:Label ID="lblPrecio" runat="server" />
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Categoría</span>
                                <span class="info-value">
                                    <asp:Label ID="lblCategoria" runat="server" />
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Estado</span>
                                <span class="info-value">
                                    <asp:Label ID="lblEstado" runat="server" />
                                </span>
                            </div>
                        </div>
                        <div class="info-item" style="margin-top: 1rem;">
                            <span class="info-label">Descripción</span>
                            <span class="info-value">
                                <asp:Label ID="lblDescripcion" runat="server" />
                            </span>
                        </div>
                    </asp:Panel>
                    
                    <!-- Reservation Info -->
                    <asp:Panel ID="pnlReserva" runat="server" CssClass="detail-card" Visible="false">
                        <h2 class="card-title">Información de Reserva</h2>
                        <div class="reservation-info">
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Fecha de Reserva</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblFechaReserva" runat="server" />
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Fecha de Finalización</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblFechaVencimiento" runat="server" />
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Monto de la Seña</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblMontoSena" runat="server" />
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Estado del Pago</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblEstadoPago" runat="server" />
                                    </span>
                                </div>
                            </div>
                            <div class="user-info-section">
                                <span class="info-label" style="font-weight: 600; margin-bottom: 0.5rem; display: block;">Usuario que Reservó</span>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <span class="info-label">Nombre Completo</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioReservaNombre" runat="server" />
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Email</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioReservaEmail" runat="server" />
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Teléfono</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioReservaTelefono" runat="server" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    
                    <!-- Sale Info -->
                    <asp:Panel ID="pnlVenta" runat="server" CssClass="detail-card" Visible="false">
                        <h2 class="card-title">Información de Venta</h2>
                        <div class="sale-info">
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">Fecha de Venta</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblFechaVenta" runat="server" />
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Precio Final</span>
                                    <span class="info-value">
                                        <asp:Label ID="lblPrecioFinal" runat="server" />
                                    </span>
                                </div>
                            </div>
                            <div class="user-info-section">
                                <span class="info-label" style="font-weight: 600; margin-bottom: 0.5rem; display: block;">Usuario Comprador</span>
                                <div class="info-grid">
                                    <div class="info-item">
                                        <span class="info-label">Nombre Completo</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioVentaNombre" runat="server" />
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Email</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioVentaEmail" runat="server" />
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">Teléfono</span>
                                        <span class="info-value">
                                            <asp:Label ID="lblUsuarioVentaTelefono" runat="server" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>

