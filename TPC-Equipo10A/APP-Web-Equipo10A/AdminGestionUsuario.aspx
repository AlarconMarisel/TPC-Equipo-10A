<%@ Page Title="Gestión de Usuarios - Admin Panel" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminGestionUsuario.aspx.cs" Inherits="APP_Web_Equipo10A.AdminGestionUsuario" %>

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
            width: 16rem;
            flex-direction: column;
            background-color: white;
            border-right: 1px solid #e2e8f0;
            padding: 1rem;
            flex-shrink: 0;
            position: sticky;
            top: 0;
            height: 100vh;
            z-index: 10;
        }
        
        .sidebar-content {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .sidebar-header {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }
        
        .sidebar-logo {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            aspect-ratio: 1;
            border-radius: 50%;
            width: 2.5rem;
            height: 2.5rem;
        }
        
        .sidebar-title {
            display: flex;
            flex-direction: column;
        }
        
        .sidebar-title-main {
            color: #0f172a;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.25;
        }
        
        .sidebar-title-sub {
            color: #64748b;
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.25;
        }
        
        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-top: 1rem;
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
        
        .nav-link:hover {
            background-color: #f1f5f9;
        }
        
        .nav-link.active {
            background-color: rgba(17, 115, 212, 0.1);
        }
        
        .nav-icon {
            color: #374151;
            font-size: 1.5rem;
        }
        
        .nav-icon.active {
            color: var(--primary-color);
        }
        
        .nav-text {
            color: #1e293b;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.25;
        }
        
        .nav-text.active {
            color: var(--primary-color);
        }
        
        .sidebar-footer {
            margin-top: auto;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .new-listing-button {
            display: flex;
            min-width: 5.25rem;
            max-width: 30rem;
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
        
        .new-listing-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .footer-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .footer-link:hover {
            background-color: #f1f5f9;
        }
        
        .footer-icon {
            color: #374151;
            font-size: 1.5rem;
        }
        
        .footer-text {
            color: #1e293b;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.25;
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
            <div class="sidebar-content">
                <div class="sidebar-header">
                    <div class="sidebar-logo" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAgPiCeeIUNVABgCnamqsdHLZDSM3cJTU1QZ-kOtek7yX_l-ZAXTuUxQ8QCQvYcFJLQNb-97SW5Vi9Jgo2rtQJdC4klkEndavZJtxTmPx5mblHmF2JiY_4jPn8Uggdkl_wAg5R5vu1_vQtCHVhuvfRnofS-E1PY2qxVQEpejCQqizST3tW2t4vELqX2erM9GChgvdgw5fQzxcOC1f_vJ4AEkGJPoBWVr5E0CCyhvNzR_RHszZniQxOCU4M3MloLnxHJXiI9CAJ5l8E");'></div>
                    <div class="sidebar-title">
                        <h1 class="sidebar-title-main">Admin Panel</h1>
                        <p class="sidebar-title-sub">Used Goods Marketplace</p>
                    </div>
                </div>
                
                <nav class="sidebar-nav">
                    <a class="nav-link" href="PanelAdministrador.aspx">
                        <span class="material-symbols-outlined nav-icon">dashboard</span>
                        <p class="nav-text">Dashboard</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">sell</span>
                        <p class="nav-text">Listings</p>
                    </a>
                    <a class="nav-link active" href="#">
                        <span class="material-symbols-outlined nav-icon active">group</span>
                        <p class="nav-text active">Users</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">shopping_cart</span>
                        <p class="nav-text">Orders</p>
                    </a>
                    <a class="nav-link" href="#">
                        <span class="material-symbols-outlined nav-icon">settings</span>
                        <p class="nav-text">Settings</p>
                    </a>
                </nav>
            </div>
            
            <div class="sidebar-footer">
                <button class="new-listing-button">
                    <span>New Listing</span>
                </button>
                
                <div class="footer-links">
                    <a class="footer-link" href="#">
                        <span class="material-symbols-outlined footer-icon">help</span>
                        <p class="footer-text">Support</p>
                    </a>
                    <a class="footer-link" href="#">
                        <span class="material-symbols-outlined footer-icon">logout</span>
                        <p class="footer-text">Log out</p>
                    </a>
                </div>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-container">
                <!-- Page Heading -->
                <div class="page-heading">
                    <div class="page-title-section">
                        <h1 class="page-title">Gestión de Usuarios</h1>
                        <p class="page-subtitle">Revisa y modifica los roles de los usuarios registrados.</p>
                    </div>
                    <button class="save-button">
                        <span>Guardar Cambios</span>
                    </button>
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
                
                <!-- Table -->
                <div class="table-container">
                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead class="table-header">
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Nombre de usuario</th>
                                    <th scope="col">Es Admin</th>
                                </tr>
                            </thead>
                            <tbody class="table-body">
                                <tr>
                                    <td class="user-id">101</td>
                                    <td class="user-email">ana.perez@email.com</td>
                                    <td class="user-name">Ana Pérez</td>
                                    <td>
                                        <input class="admin-checkbox" type="checkbox" checked />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="user-id">102</td>
                                    <td class="user-email">carlos.gomez@email.com</td>
                                    <td class="user-name">Carlos Gómez</td>
                                    <td>
                                        <input class="admin-checkbox" type="checkbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="user-id">103</td>
                                    <td class="user-email">beatriz.martin@email.com</td>
                                    <td class="user-name">Beatriz Martín</td>
                                    <td>
                                        <input class="admin-checkbox" type="checkbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="user-id">104</td>
                                    <td class="user-email">david.sanchez@email.com</td>
                                    <td class="user-name">David Sánchez</td>
                                    <td>
                                        <input class="admin-checkbox" type="checkbox" checked />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="user-id">105</td>
                                    <td class="user-email">elena.ruiz@email.com</td>
                                    <td class="user-name">Elena Ruiz</td>
                                    <td>
                                        <input class="admin-checkbox" type="checkbox" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Pagination -->
                <div class="pagination-container">
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
                </div>
            </div>
        </main>
        
        <!-- Toast Notification -->
        <div class="toast-container">
            <div class="toast">
                <span class="material-symbols-outlined toast-icon">check_circle</span>
                <p>Roles actualizados correctamente.</p>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

