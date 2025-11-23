<%@ Page Title="Gestión de Usuarios - Admin Panel" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="AdminGestionUsuario.aspx.cs" Inherits="APP_Web_Equipo10A.AdminGestionUsuario" %>

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
        
        .sidebar-footer {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }
        
        .content-container {
            max-width: 80rem;
            margin: 0 auto;
        }
        
        /* Page Heading */
        .page-heading {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .page-title-section {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .page-title {
            color: #0f172a;
            font-size: 1.875rem;
            font-weight: 900;
            letter-spacing: -0.025em;
        }
        
        .page-subtitle {
            color: #64748b;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.25;
        }
        
        .save-button {
            display: flex;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 2.5rem;
            padding: 0 1rem;
            background-color: var(--primary-color);
            color: white;
            font-size: 0.875rem;
            font-weight: 700;
            line-height: 1.25;
            letter-spacing: 0.015em;
            border: none;
            transition: all 0.2s ease;
        }
        
        .save-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        .save-button:disabled {
            background-color: #cbd5e1;
            cursor: not-allowed;
        }
        
        /* Search Bar */
        .search-container {
            margin-bottom: 1rem;
        }
        
        .search-wrapper {
            display: flex;
            flex-direction: column;
            min-width: 10rem;
            height: 3rem;
            width: 100%;
            max-width: 24rem;
        }
        
        .users-search-input-container {
            display: flex;
            width: 100%;
            flex: 1;
            align-items: center;
            border-radius: 0.5rem;
            height: 100%;
            position: relative;
            border: 1px solid #cbd5e1; 
            background-color: white;
            overflow: hidden;
        }
        
        .users-search-icon-container {
            display: flex;
            align-items: center;
            color: #64748b;
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            padding-left: 12px;
            padding-right: 6px;
            background-color: white;
            pointer-events: none;
        }
        
        .search-icon {
            font-size: 1.5rem;
        }
        
        .users-search-input {
            display: flex;
            width: 100%;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 0.5rem;
            color: #0f172a;
            border: none; 
            background-color: transparent;
            height: 100%;
            padding: 0 1rem 0 2.25rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.25;
            transition: all 0.2s ease;
        }
        
        .users-search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        .users-search-input::placeholder {
            color: #94a3b8;
        }
        
        /* Table */
        .table-container {
            overflow-x: auto;
        }
        
        .table-wrapper {
            display: inline-block;
            min-width: 100%;
            vertical-align: middle;
        }
        
        .data-table {
            min-width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            background-color: white;
        }
        
        .data-table td, .data-table th {
            padding: 1rem 1.5rem;
            text-align: left;
        }
        
        .data-table tr:hover {
            background-color: #f8fafc;
        }
        
        .table-header {
            background-color: #f8fafc;
        }
        
        .table-header th {
            padding: 0.75rem 1.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 500;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .table-body {
            background-color: white;
        }
        
        .table-body tr {
            border-bottom: 1px solid #e2e8f0;
        }
        
        .table-body tr:last-child {
            border-bottom: none;
        }
        
        .table-body tr:hover {
            background-color: #f8fafc;
        }
        
        .table-body td {
            padding: 1rem 1.5rem;
            white-space: nowrap;
            font-size: 0.875rem;
        }
        
        .user-id {
            color: #64748b;
        }
        
        .user-email {
            color: #64748b;
        }
        
        .user-name {
            font-weight: 500;
            color: #0f172a;
        }
        
        .admin-checkbox {
            height: 1.25rem;
            width: 1.25rem;
            border-radius: 0.25rem;
            border: 1px solid #cbd5e1;
            background-color: white;
            color: var(--primary-color);
            transition: all 0.2s ease;
        }
        
        .admin-checkbox:checked {
            background-color: var(--primary-color);
            border-color: transparent;
        }
        
        .admin-checkbox:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        /* Badges */
        .badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .badge-success {
            background-color: #d1fae5;
            color: #065f46;
        }
        
        .badge-danger {
            background-color: #fee2e2;
            color: #991b1b;
        }
        
        /* Buttons */
        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .btn-sm {
            padding: 0.25rem 0.75rem;
            font-size: 0.75rem;
        }
        
        .btn-danger {
            background-color: #dc2626;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #b91c1c;
        }
        
        .btn-success {
            background-color: #059669;
            color: white;
        }
        
        .btn-success:hover {
            background-color: #047857;
        }
        
        /* Alerts */
        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }
        
        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }
        
        .validacion {
            color: #dc2626;
            font-size: 0.875rem;
        }
        
        /* Pagination */
        .pagination-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 1.5rem;
        }
        
        .pagination-nav {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .pagination-link {
            display: flex;
            width: 2.5rem;
            height: 2.5rem;
            align-items: center;
            justify-content: center;
            color: #64748b;
            text-decoration: none;
            border-radius: 0.5rem;
            transition: all 0.2s ease;
        }
        
        .pagination-link:hover {
            background-color: #f1f5f9;
        }
        
        .pagination-link.active {
            color: white;
            background-color: var(--primary-color);
            font-weight: 700;
        }
        
        .pagination-link.normal {
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.25;
            color: #475569;
        }
        
        .pagination-link.normal:hover {
            background-color: #f1f5f9;
        }
        
        .pagination-ellipsis {
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.25;
            color: #64748b;
            display: flex;
            width: 2.5rem;
            height: 2.5rem;
            align-items: center;
            justify-content: center;
            border-radius: 0.5rem;
        }
        
        .pagination-icon {
            font-size: 1.125rem;
        }
        
        /* Toast Notification */
        .toast-container {
            position: fixed;
            bottom: 1.5rem;
            right: 1.5rem;
        }
        
        .toast {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            background-color: #10b981;
            color: white;
            font-size: 0.875rem;
            font-weight: 600;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            animation: toast-in 0.3s ease-out forwards;
        }
        
        .toast-icon {
            font-size: 1.125rem;
        }
        
        @keyframes toast-in {
            from {
                transform: translateY(100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
       
        @media (max-width: 768px) {
            .admin-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                padding: 1rem;
                flex: 1;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .page-heading {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .search-wrapper {
                max-width: 100%;
            }
            
            .table-body td {
                padding: 0.75rem 1rem;
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
                    </div>
                </div>
                
                <!-- Navigation -->
                <nav class="sidebar-nav">
                    <a class="nav-link" href="PanelAdministrador.aspx">
                        <span class="material-symbols-outlined nav-icon" style="font-variation-settings: 'FILL' 1;">dashboard</span>
                        <p class="nav-text">Dashboard</p>
                    </a>
                    <a class="nav-link" href="AdminGestionArticulo.aspx">
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
                    <a class="nav-link active" href="AdminGestionUsuario.aspx">
                        <span class="material-symbols-outlined nav-icon">group</span>
                        <p class="nav-text">Usuarios</p>
                    </a>
                    <a class="nav-link" href="AdminConfiguracionTienda.aspx">
                        <span class="material-symbols-outlined nav-icon">settings</span>
                        <p class="nav-text">Configuración</p>
                    </a>
                </nav>
            </div>
            
            <!-- Footer Links -->
            <div class="sidebar-footer">
                <a class="nav-link" href="javascript:void(0);" onclick="alert('Funcionalidad de Mi Perfil próximamente'); return false;">
                    <span class="material-symbols-outlined nav-icon">account_circle</span>
                    <p class="nav-text">Mi Perfil</p>
                </a>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-container">
                <!-- Page Heading -->
                <div class="page-heading">
                    <div class="page-title-section">
                        <h1 class="page-title">Gestión de Usuarios</h1>
                        <p class="page-subtitle">Gestiona los usuarios normales de tu tienda. Puedes dar de baja o reactivar usuarios.</p>
                    </div>
                </div>
                
                <!-- Search Bar -->
                <div class="search-container">
                    <label class="search-wrapper">
                        <div class="users-search-input-container">
                            <div class="users-search-icon-container">
                                <span class="material-symbols-outlined search-icon">search</span>
                            </div>
                            <input class="users-search-input" type="text" placeholder="Buscar por nombre o email..." />
                        </div>
                    </label>
                </div>
                
                <!-- Mensaje de error/éxito -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="validacion" Visible="false"></asp:Label>
                
                <!-- Table -->
                <div class="table-container">
                    <div class="table-wrapper">
                        <asp:GridView ID="gvUsuarios" runat="server" CssClass="data-table" AutoGenerateColumns="false" 
                            OnRowCommand="gvUsuarios_RowCommand" EmptyDataText="No hay usuarios registrados.">
                            <Columns>
                                <asp:BoundField DataField="IdUsuario" HeaderText="ID" ItemStyle-CssClass="user-id" />
                                <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre" ItemStyle-CssClass="user-name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-CssClass="user-email" />
                                <asp:BoundField DataField="FechaAltaFormateada" HeaderText="Fecha Registro" />
                                <asp:TemplateField HeaderText="Estado">
                                    <ItemTemplate>
                                        <span class='<%# Eval("Eliminado").ToString() == "True" ? "badge badge-danger" : "badge badge-success" %>'>
                                            <%# Eval("Eliminado").ToString() == "True" ? "Inactivo" : "Activo" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDarDeBaja" runat="server" 
                                            CommandName="DarDeBaja" 
                                            CommandArgument='<%# Eval("IdUsuario") %>'
                                            Text="Dar de Baja"
                                            CssClass="btn btn-danger btn-sm"
                                            Visible='<%# Eval("Eliminado").ToString() == "False" %>'
                                            OnClientClick="return confirm('¿Está seguro de dar de baja a este usuario?');" />
                                        <asp:LinkButton ID="btnReactivar" runat="server" 
                                            CommandName="Reactivar" 
                                            CommandArgument='<%# Eval("IdUsuario") %>'
                                            Text="Reactivar"
                                            CssClass="btn btn-success btn-sm"
                                            Visible='<%# Eval("Eliminado").ToString() == "True" %>'
                                            OnClientClick="return confirm('¿Está seguro de reactivar a este usuario?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                
                <!-- Pagination - Solo mostrar si hay usuarios -->
                <asp:Panel ID="pnlPaginacion" runat="server" CssClass="pagination-container" Visible="false">
                    <nav class="pagination-nav">
                        <a class="pagination-link" href="#">
                            <span class="material-symbols-outlined pagination-icon">chevron_left</span>
                        </a>
                        <a class="pagination-link active" href="#">1</a>
                        <a class="pagination-link normal" href="#">2</a>
                        <a class="pagination-link normal" href="#">3</a>
                        <span class="pagination-ellipsis">...</span>
                        <a class="pagination-link normal" href="#">10</a>
                        <a class="pagination-link" href="#">
                            <span class="material-symbols-outlined pagination-icon">chevron_right</span>
                        </a>
                    </nav>
                </asp:Panel>
            </div>
        </main>
        
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

