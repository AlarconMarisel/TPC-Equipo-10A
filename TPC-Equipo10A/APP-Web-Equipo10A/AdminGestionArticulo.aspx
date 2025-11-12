<%@ Page Title="Gestión de Artículos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminGestionArticulo.aspx.cs" Inherits="APP_Web_Equipo10A.AdminGestionArticulo" %>

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
            flex-direction: column;
            width: 16rem;
            background-color: white;
            border-right: 1px solid #e2e8f0;
            padding: 1rem;
            flex-shrink: 0;
            position: sticky;
            top: 0;
            height: 100vh;
            z-index: 10;
        }
        
        .sidebar-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
        }
        
        .sidebar-logo {
            color: var(--primary-color);
            font-size: 1.875rem;
        }
        
        .sidebar-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .sidebar-content {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            margin-top: 1rem;
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
            color: #475569;
        }
        
        .nav-link:not(.active):hover {
            background-color: #f1f5f9;
        }
        
        .nav-icon {
            font-size: 1.5rem;
        }
        
        .nav-text {
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .nav-text.bold {
            font-weight: 700;
        }
        
        .sidebar-footer {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            color: #475569;
            transition: all 0.2s ease;
        }
        
        .user-info:hover {
            background-color: #f1f5f9;
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
        
        .user-details {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-size: 0.875rem;
            font-weight: 500;
            color: #1e293b;
            line-height: 1.25;
        }
        
        .user-email {
            font-size: 0.75rem;
            color: #64748b;
            line-height: 1.25;
        }
        
        .logout-link {
            color: rgba(220, 53, 69, 0.8);
        }
        
        .logout-link:hover {
            background-color: rgba(220, 53, 69, 0.1);
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
        }
        
        @media (min-width: 768px) {
            .toolbar {
                flex-direction: row;
                align-items: center;
                justify-content: space-between;
            }
        }
        
        .search-container {
            position: relative;
            width: 100%;
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
        }
        
        .search-input {
            width: 100%;
            border-radius: 0.5rem;
            border: 1px solid #cbd5e1;
            background-color: white;
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            font-size: 0.875rem;
            color: #1e293b;
            transition: all 0.2s ease;
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1);
        }
        
        .search-input::placeholder {
            color: #94a3b8;
        }
        
        .toolbar-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        @media (min-width: 640px) {
            .toolbar-actions {
                flex-direction: row;
                align-items: center;
            }
        }
        
        .filter-buttons {
            display: flex;
            gap: 0.5rem;
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
        
        .product-image {
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 0.5rem;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .product-name {
            font-weight: 500;
            color: #1e293b;
        }
        
        .product-details {
            color: #64748b;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            border-radius: 9999px;
            padding: 0.125rem 0.625rem;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .status-available {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .status-reserved {
            background-color: rgba(255, 193, 7, 0.1);
            color: #b45309;
        }
        
        .status-sold {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
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
        
        /* Pagination */
        .pagination {
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 0.5rem;
        }
        
        .pagination-link {
            display: flex;
            width: 2.25rem;
            height: 2.25rem;
            align-items: center;
            justify-content: center;
            border-radius: 0.5rem;
            color: #64748b;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .pagination-link:hover {
            background-color: #f1f5f9;
        }
        
        .pagination-link.active {
            background-color: rgba(17, 115, 212, 0.2);
            color: var(--primary-color);
            font-weight: 700;
        }
        
        .pagination-link.normal {
            font-size: 0.875rem;
            font-weight: 400;
        }
        
        .pagination-ellipsis {
            display: flex;
            width: 2.25rem;
            height: 2.25rem;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            font-weight: 400;
            color: #475569;
        }
        
        .pagination-icon {
            font-size: 1.25rem;
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
                <span class="material-symbols-outlined sidebar-logo">storefront</span>
                <h1 class="sidebar-title">Segunda Vida</h1>
            </div>
            
            <div class="sidebar-content">
                <!-- Navigation -->
                <nav class="sidebar-nav">
                    <a class="nav-link" href="PanelAdministrador.aspx">
                        <span class="material-symbols-outlined nav-icon">dashboard</span>
                        <p class="nav-text">Dashboard</p>
                    </a>
                    <a class="nav-link active" href="#">
                        <span class="material-symbols-outlined nav-icon">inventory_2</span>
                        <p class="nav-text bold">Gestión de Artículos</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">shopping_cart</span>
                        <p class="nav-text">Pedidos</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">group</span>
                        <p class="nav-text">Clientes</p>
                    </a>
                </nav>
                
                <!-- Footer -->
                <div class="sidebar-footer">
                    <div class="user-info">
                        <div class="user-avatar" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAZkHszPKnmh_FnWUjKGOw-yoPCOiqduLs4ARXKt0-dAXSWRlUIfPSWMWBaTLrrcVwMIcyVDSWy34JHMq8lNJ3R8vT6sMEBOZ4dqjdu7hHE4bs09Yiuq7-sROgvC7Qwntv7pDh0ZPay1YCOjfqPu2rPpKNxbH3P6catl5ZPbjKIKQNvCFRqZgjoukrliR8q-ppl88gypFBtKnC3wLEjeFaLn8wLkZRE_bZqIjBJ2rjYReXMnQU_7rpf1aXgXwT6iE1uSwpzLVoqpnQ");'></div>
                        <div class="user-details">
                            <h1 class="user-name">Admin</h1>
                            <p class="user-email">admin@segundavida.com</p>
                        </div>
                    </div>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">settings</span>
                        <p class="nav-text">Ajustes</p>
                    </a>
                    <a class="nav-link logout-link" href="#">
                        <span class="material-symbols-outlined nav-icon">logout</span>
                        <p class="nav-text">Cerrar Sesión</p>
                    </a>
                </div>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <!-- Page Heading -->
                <div class="page-heading">
                    <div class="page-title-section">
                        <p class="page-title">Gestión de Artículos</p>
                        <p class="page-subtitle">Gestiona, agrega y edita todos los artículos de tu inventario.</p>
                    </div>
                </div>
                
                <!-- Main content wrapper -->
                <div class="main-content-wrapper">
                    <!-- Toolbar -->
                    <div class="toolbar">
                        <div class="search-container">
                            <span class="material-symbols-outlined search-icon">search</span>
                            <input class="search-input" type="text" placeholder="Buscar por nombre o SKU..." />
                        </div>
                        
                        <div class="toolbar-actions">
                            <div class="filter-buttons">
                                <button class="filter-button">
                                    <span class="material-symbols-outlined">filter_list</span>
                                    <span>Estado</span>
                                </button>
                                <button class="filter-button">
                                    <span class="material-symbols-outlined">category</span>
                                    <span>Categoría</span>
                                </button>
                            </div>
                            <a href="AdminFormularioArticulo.aspx" class="add-button text-decoration-none d-inline-flex align-items-center">
                                <span class="material-symbols-outlined">add_circle</span>
                                <span class="add-button-text">Agregar Nuevo Artículo</span>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Table -->
                    <div class="table-container">
                        <div class="table-wrapper">
                            <table class="data-table">
                                <thead class="table-header">
                                    <tr>
                                        <th>Imagen</th>
                                        <th>Nombre del Artículo</th>
                                        <th>SKU</th>
                                        <th>Precio</th>
                                        <th>Stock</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="table-body">
                                    <asp:Repeater ID="repArticulos" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="product-image" style='background-image: url("<%# GetImagenUrl(Container.DataItem) %>");'></div>
                                                </td>
                                                <td class="product-name"><%# Eval("Nombre") %></td>
                                                <td class="product-details">SKU-<%# Eval("IdArticulo") %></td>
                                                <td class="product-details">$<%# string.Format("{0:N2}", Eval("Precio")) %></td>
                                                <td class="product-details">-</td>
                                                <td>
                                                    <span class="status-badge status-available"><%# Eval("EstadoArticulo.Nombre") %></span>
                                                </td>
                                                <td>
                                                    <div class="actions-container">
                                                        <a href='AdminFormularioArticulo.aspx?id=<%# Eval("IdArticulo") %>' class="action-button" title="Editar">
                                                            <span class="material-symbols-outlined action-icon">edit</span>
                                                        </a>
                                                        <a href="#" class="action-button" title="Ver">
                                                            <span class="material-symbols-outlined action-icon">visibility</span>
                                                        </a>
                                                        <a href="#" class="action-button delete" title="Eliminar">
                                                            <span class="material-symbols-outlined action-icon">delete</span>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:Label ID="lblSinArticulos" runat="server" Visible="false">
                                        <tr>
                                            <td colspan="7" class="text-center" style="padding: 2rem;">
                                                <p class="text-muted">No hay artículos disponibles.</p>
                                            </td>
                                        </tr>
                                    </asp:Label>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="pagination">
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
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">

</asp:Content>

