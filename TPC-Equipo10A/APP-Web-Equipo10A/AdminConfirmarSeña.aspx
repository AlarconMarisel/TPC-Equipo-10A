<%@ Page Title="Gestión de Señas Pendientes" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="AdminConfirmarSeña.aspx.cs" Inherits="APP_Web_Equipo10A.AdminConfirmarSeña" %>

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
            border-right: 1px solid #e5e7eb;
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
            margin-bottom: 2rem;
        }
        
        .sidebar-logo {
            background-color: rgba(17, 115, 212, 0.2);
            border-radius: 0.5rem;
            padding: 0.5rem;
            color: var(--primary-color);
        }
        
        .sidebar-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #111827;
        }
        
        .sidebar-content {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            flex: 1;
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
            background-color: rgba(17, 115, 212, 0.1);
            color: var(--primary-color);
        }
        
        .nav-link:not(.active) {
            color: #6b7280;
        }
        
        .nav-link:not(.active):hover {
            background-color: #f3f4f6;
        }
        
        .nav-icon {
            font-size: 1.5rem;
        }
        
        .nav-text {
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .sidebar-footer {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
            border-top: 1px solid #e5e7eb;
            padding-top: 0.4rem;
            margin-top: 0.4rem;
        }
        
        .user-info {
            display: flex;
            gap: 0.75rem;
            align-items: center;
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
            color: #111827;
        }
        
        .user-email {
            font-size: 0.75rem;
            color: #6b7280;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            padding: 1.5rem 2.5rem;
            overflow-y: auto;
        }
        
        @media (min-width: 1024px) {
            .main-content {
                padding: 2.5rem;
            }
        }
        
        .content-container {
            width: 100%;
            max-width: 80rem;
            margin: 0 auto;
        }
        
        /* Breadcrumbs */
        .breadcrumbs {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .breadcrumb-link {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s ease;
        }
        
        .breadcrumb-link:hover {
            color: var(--primary-color);
        }
        
        .breadcrumb-separator {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .breadcrumb-current {
            color: #1f2937;
            font-size: 0.875rem;
            font-weight: 500;
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
        
        .page-title {
            color: #111827;
            font-size: 1.875rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.03em;
        }
        
        /* Search Bar */
        .search-container {
            margin-bottom: 1.5rem;
        }
        
        .search-input-container {
            position: relative;
        }
        
        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        
        .search-input {
            display: flex;
            width: 100%;
            max-width: 32rem;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 0.5rem;
            color: #111827;
            border: 1px solid #d1d5db;
            background-color: white;
            height: 3rem;
            padding: 0 1rem 0 2.5rem;
            font-size: 0.875rem;
            font-weight: 400;
            transition: all 0.2s ease;
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1);
        }
        
        .search-input::placeholder {
            color: #9ca3af;
        }
        
        /* Table Container */
        .table-container {
            overflow: hidden;
            border-radius: 0.75rem;
            border: 1px solid #e5e7eb;
            background-color: white;
        }
        
        .table-wrapper {
            overflow-x: auto;
        }
        
        .data-table {
            min-width: 100%;
            border-collapse: collapse;
        }
        
        .table-header {
            background-color: #f9fafb;
        }
        
        .table-header th {
            padding: 0.75rem 1.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 500;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .table-body {
            background-color: white;
        }
        
        .table-body tr {
            border-bottom: 1px solid #e5e7eb;
        }
        
        .table-body tr:last-child {
            border-bottom: none;
        }
        
        .table-body td {
            padding: 1rem 1.5rem;
            white-space: nowrap;
            font-size: 0.875rem;
        }
        
        .reservation-id {
            font-weight: 500;
            color: #111827;
        }
        
        .table-text {
            color: #6b7280;
        }
        
        .actions-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .action-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            height: 2.25rem;
            padding: 0 1rem;
            font-size: 0.875rem;
            font-weight: 600;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .confirm-button {
            color: white;
            background-color: #28a745;
        }
        
        .confirm-button:hover {
            background-color: #218838;
        }
        
        .cancel-button {
            color: white;
            background-color: #dc3545;
        }
        
        .cancel-button:hover {
            background-color: #c82333;
        }
        
        .action-icon {
            font-size: 1.125rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
        }
        
        .empty-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #dcfce7;
            border-radius: 50%;
            width: 4rem;
            height: 4rem;
            margin-bottom: 1rem;
        }
        
        .empty-icon-symbol {
            color: #16a34a;
            font-size: 2rem;
        }
        
        .empty-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #111827;
        }
        
        .empty-description {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 0.25rem;
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
            
            .search-input {
                max-width: 100%;
            }
            
            .table-body td {
                padding: 0.75rem 1rem;
            }
            
            .actions-container {
                flex-direction: column;
                gap: 0.25rem;
            }
            
            .action-button {
                width: 100%;
                justify-content: center;
            }
        }

       
        @media (min-width: 769px) {
            .admin-container { flex-direction: row; }
            .sidebar { width: 16rem; height: 100vh; position: sticky; top: 0; flex-shrink: 0; }
            .main-content { flex: 1; padding: 2.5rem; overflow-y: auto; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <span class="material-symbols-outlined">storefront</span>
                </div>
                <h1 class="sidebar-title">Admin Panel</h1>
            </div>
            
            <div class="sidebar-content">
                <!-- Navigation -->
                <nav class="sidebar-nav">
                    <a class="nav-link" href="PanelAdministrador.aspx">
                        <span class="material-symbols-outlined nav-icon">dashboard</span>
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
                    <a class="nav-link active" href="AdminConfirmarSeña.aspx">
                        <span class="material-symbols-outlined nav-icon">receipt_long</span>
                        <p class="nav-text">Señas Pendientes</p>
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
            <div class="content-container">
                <!-- Breadcrumbs -->
                <div class="breadcrumbs">
                    <a class="breadcrumb-link" href="PanelAdministrador.aspx">Dashboard</a>
                    <span class="breadcrumb-separator">/</span>
                    <span class="breadcrumb-current">Señas Pendientes de Confirmar</span>
                </div>
                
                <!-- Page Heading -->
                <div class="page-heading">
                    <h1 class="page-title">Gestión de Señas Pendientes</h1>
                </div>
                
                <!-- Search Bar -->
                <div class="search-container">
                    <div class="search-input-container">
                        <span class="material-symbols-outlined search-icon">search</span>
                        <input class="search-input" type="text" placeholder="Buscar por ID de reserva o email de usuario" value="" />
                    </div>
                </div>
                
                <!-- Table Container -->
                <div class="table-container">
                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead class="table-header">
                                <tr>
                                    <th scope="col">ID Reserva</th>
                                    <th scope="col">Fecha Solicitud</th>
                                    <th scope="col">Usuario (Email)</th>
                                    <th scope="col">Monto Seña</th>
                                    <th scope="col">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="table-body">
                                <tr>
                                    <td class="reservation-id">R-789012</td>
                                    <td class="table-text">2023-10-26 14:30</td>
                                    <td class="table-text">juan.perez@email.com</td>
                                    <td class="table-text">$25.00</td>
                                    <td>
                                        <div class="actions-container">
                                            <button class="action-button confirm-button">
                                                <span class="material-symbols-outlined action-icon">check_circle</span>
                                                Confirmar Pago
                                            </button>
                                            <button class="action-button cancel-button">
                                                <span class="material-symbols-outlined action-icon">cancel</span>
                                                Cancelar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="reservation-id">R-789013</td>
                                    <td class="table-text">2023-10-26 11:05</td>
                                    <td class="table-text">maria.gomez@email.com</td>
                                    <td class="table-text">$50.00</td>
                                    <td>
                                        <div class="actions-container">
                                            <button class="action-button confirm-button">
                                                <span class="material-symbols-outlined action-icon">check_circle</span>
                                                Confirmar Pago
                                            </button>
                                            <button class="action-button cancel-button">
                                                <span class="material-symbols-outlined action-icon">cancel</span>
                                                Cancelar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="reservation-id">R-789014</td>
                                    <td class="table-text">2023-10-25 21:15</td>
                                    <td class="table-text">carlos.lopez@email.com</td>
                                    <td class="table-text">$15.50</td>
                                    <td>
                                        <div class="actions-container">
                                            <button class="action-button confirm-button">
                                                <span class="material-symbols-outlined action-icon">check_circle</span>
                                                Confirmar Pago
                                            </button>
                                            <button class="action-button cancel-button">
                                                <span class="material-symbols-outlined action-icon">cancel</span>
                                                Cancelar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="reservation-id">R-789015</td>
                                    <td class="table-text">2023-10-25 18:00</td>
                                    <td class="table-text">ana.martinez@email.com</td>
                                    <td class="table-text">$32.00</td>
                                    <td>
                                        <div class="actions-container">
                                            <button class="action-button confirm-button">
                                                <span class="material-symbols-outlined action-icon">check_circle</span>
                                                Confirmar Pago
                                            </button>
                                            <button class="action-button cancel-button">
                                                <span class="material-symbols-outlined action-icon">cancel</span>
                                                Cancelar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Empty State (comentado) -->
                <!-- 
                <div class="empty-state">
                    <div class="empty-icon">
                        <span class="material-symbols-outlined empty-icon-symbol">task_alt</span>
                    </div>
                    <h3 class="empty-title">¡Buen trabajo!</h3>
                    <p class="empty-description">No hay señas pendientes por confirmar en este momento.</p>
                </div>
                -->
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">

</asp:Content>

