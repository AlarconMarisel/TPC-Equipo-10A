<%@ Page Title="Gestión de Categorías" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminGestionCategoria.aspx.cs" Inherits="APP_Web_Equipo10A.AdminGestionCategoria" %>

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
            overflow-y: auto;
            padding: 2rem;
        }
        
        .content-wrapper {
            max-width: 80rem;
            margin: 0 auto;
            padding: 1.5rem 2rem;
        }
        
        @media (min-width: 1024px) {
            .content-wrapper {
                padding: 2rem;
            }
        }
        
        /* Page Heading */
        .page-heading {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
        }
        
        .page-title-section {
            display: flex;
            min-width: 18rem;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .page-title {
            color: #1e293b;
            font-size: 1.875rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.025em;
        }
        
        .page-subtitle {
            color: #64748b;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
        }
        
        /* Main Content Wrapper */
        .main-content-wrapper {
            margin-top: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        /* Toolbar */
        .toolbar {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: stretch;
        }
        
        @media (min-width: 768px) {
            .toolbar {
                flex-direction: row;
                align-items: center;
                justify-content: space-between;
            }
        }
        
        /* Clase común para todos los controles del toolbar - FORZAR MISMA ALTURA */
        .toolbar input[type="text"],
        .toolbar input[type="text"]:focus,
        .toolbar button,
        .toolbar button:focus,
        .toolbar .search-container {
            height: 2.5rem !important;
            min-height: 2.5rem !important;
            max-height: 2.5rem !important;
            box-sizing: border-box !important;
            margin: 0 !important;
        }
        
        #txtBusqueda,
        #MainContent_txtBusqueda {
            height: 2.5rem !important;
            min-height: 2.5rem !important;
            max-height: 2.5rem !important;
            box-sizing: border-box !important;
            margin: 0 !important;
            width: 100% !important;
            position: relative;
            line-height: 1.5 !important;
        }
        
        .search-container {
            position: relative;
            width: 100%;
            display: block;
        }
        
        @media (min-width: 768px) {
            .search-container {
                max-width: 20rem;
            }
        }
        
        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            z-index: 1;
            pointer-events: none;
        }
        
        .search-input {
            width: 100% !important;
            border-radius: 0.5rem !important;
            border: 1px solid #cbd5e1 !important;
            background-color: white !important;
            padding: 0.5rem 1rem 0.5rem 2.5rem !important;
            font-size: 0.875rem !important;
            color: #1e293b !important;
            transition: all 0.2s ease;
            box-sizing: border-box !important;
            height: 2.5rem !important;
            line-height: 1.5 !important;
            margin: 0 !important;
        }
        
        .search-input:focus {
            outline: none !important;
            border-color: var(--primary-color) !important;
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1) !important;
        }
        
        .search-input::placeholder {
            color: #94a3b8;
        }
        
        .toolbar-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: stretch;
        }
        
        @media (min-width: 640px) {
            .toolbar-actions {
                flex-direction: row;
                align-items: center;
            }
        }
        
        .filter-button {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            border-radius: 0.5rem;
            border: 1px solid #cbd5e1;
            background-color: white;
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: #374151;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            height: 2.5rem;
            box-sizing: border-box;
        }
        
        #btnBuscar,
        #MainContent_btnBuscar {
            height: 2.5rem !important;
            min-height: 2.5rem !important;
            max-height: 2.5rem !important;
            box-sizing: border-box !important;
            vertical-align: middle !important;
            margin: 0 !important;
            line-height: 1.5 !important;
        }
        
        .filter-button:hover {
            background-color: #f8fafc;
        }
        
        .add-button {
            display: flex;
            width: 100%;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            overflow: hidden;
            border-radius: 0.5rem;
            background-color: var(--primary-color);
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
        }
        
        .add-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        @media (min-width: 640px) {
            .add-button {
                width: auto;
            }
        }
        
        .add-button-text {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        /* Table */
        .table-container {
            width: 100%;
            overflow: hidden;
        }
        
        .table-wrapper {
            overflow-x: auto;
            border-radius: 0.5rem;
            border: 1px solid #e2e8f0;
            background-color: white;
        }
        
        .data-table {
            min-width: 100%;
            font-size: 0.875rem;
            border-collapse: collapse;
        }
        
        .table-header {
            background-color: #f8fafc;
            text-align: left;
            color: #475569;
        }
        
        .table-header th {
            padding: 0.75rem 1rem;
            font-weight: 500;
        }
        
        .table-body {
            background-color: white;
        }
        
        .table-body tr {
            color: #374151;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .table-body tr:last-child {
            border-bottom: none;
        }
        
        .table-body tr:hover {
            background-color: #f8fafc;
        }
        
        .table-body td {
            padding: 0.75rem 1rem;
        }
        
        .category-name {
            font-weight: 500;
            color: #1e293b;
        }
        
        .actions-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #64748b;
        }
        
        .action-button {
            border-radius: 0.375rem;
            padding: 0.375rem;
            color: inherit;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .action-button:hover {
            background-color: #f1f5f9;
            color: #1e293b;
        }
        
        .action-button.delete:hover {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .action-icon {
            font-size: 1.125rem;
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
                flex: 1;
            }
            
            .content-wrapper {
                padding: 1rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .search-container {
                max-width: 100%;
            }
            
            .table-body td {
                padding: 0.5rem 0.75rem;
            }
            
            .actions-container {
                flex-direction: column;
                gap: 0.25rem;
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
                    <a class="nav-link active" href="AdminGestionCategoria.aspx">
                        <span class="material-symbols-outlined nav-icon">category</span>
                        <p class="nav-text">Categorías</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">receipt_long</span>
                        <p class="nav-text">Ventas</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">group</span>
                        <p class="nav-text">Usuarios</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">mail</span>
                        <p class="nav-text">Mensajes</p>
                    </a>
                </nav>
            </div>
            
            <!-- Footer Links -->
            <div class="sidebar-footer">
                <a class="nav-link" href="#">
                    <span class="material-symbols-outlined nav-icon">account_circle</span>
                    <p class="nav-text">Mi Perfil</p>
                </a>
                <a class="nav-link" href="#">
                    <span class="material-symbols-outlined nav-icon">logout</span>
                    <p class="nav-text">Cerrar Sesión</p>
                </a>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <!-- Page Heading -->
                <div class="page-heading">
                    <div class="page-title-section">
                        <p class="page-title">Gestión de Categorías</p>
                        <p class="page-subtitle">Gestiona, agrega y edita todas las categorías de tu inventario.</p>
                    </div>
                </div>
                
                <!-- Main content wrapper -->
                <div class="main-content-wrapper">
                    <!-- Toolbar -->
                    <div class="toolbar">
                        <div class="search-container">
                            <span class="material-symbols-outlined search-icon">search</span>
                            <asp:TextBox ID="txtBusqueda" runat="server" CssClass="search-input" placeholder="Buscar por nombre..." AutoPostBack="false"></asp:TextBox>
                        </div>
                        
                        <div class="toolbar-actions">
                            <asp:Button ID="btnBuscar" runat="server" CssClass="filter-button" Text="Buscar" OnClick="btnBuscar_Click" />
                            <a href="AdminFormularioCategoria.aspx" class="add-button text-decoration-none d-inline-flex align-items-center">
                                <span class="material-symbols-outlined">add_circle</span>
                                <span class="add-button-text">Agregar Nueva Categoría</span>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Table -->
                    <div class="table-container">
                        <div class="table-wrapper">
                            <table class="data-table">
                                <thead class="table-header">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="table-body">
                                    <asp:Repeater ID="repCategorias" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("IdCategoria") %></td>
                                                <td class="category-name"><%# Eval("Nombre") %></td>
                                                <td>
                                                    <div class="actions-container">
                                                        <a href='AdminFormularioCategoria.aspx?id=<%# Eval("IdCategoria") %>' class="action-button" title="Editar">
                                                            <span class="material-symbols-outlined action-icon">edit</span>
                                                        </a>
                                                        <asp:LinkButton ID="btnEliminar" runat="server" CssClass="action-button delete" 
                                                            CommandArgument='<%# Eval("IdCategoria") %>' OnClick="btnEliminar_Click"
                                                            OnClientClick="return confirm('¿Está seguro de eliminar esta categoría?');" title="Eliminar">
                                                            <span class="material-symbols-outlined action-icon">delete</span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:Label ID="lblSinCategorias" runat="server" Visible="false">
                                        <tr>
                                            <td colspan="3" class="text-center" style="padding: 2rem;">
                                                <p class="text-muted">No hay categorías disponibles.</p>
                                            </td>
                                        </tr>
                                    </asp:Label>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">

</asp:Content>

