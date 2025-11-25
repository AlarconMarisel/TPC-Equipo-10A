<%@ Page Title="Panel de Administrador" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="PanelAdministrador.aspx.cs" Inherits="APP_Web_Equipo10A.PanelAdministrador" %>

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
        
        .sidebar-footer {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
            border-top: 1px solid #e5e7eb;
            padding-top: 0.4rem;
            margin-top: 0.4rem;
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
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
            line-height: 1.5;
            text-decoration: none;
        }
        
        .breadcrumb-separator {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        .breadcrumb-current {
            color: #111827;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        /* Page Header */
        .page-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            margin-bottom: 2rem;
        }
        
        .page-title-section {
            display: flex;
            min-width: 18rem;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .page-title {
            color: #111827;
            font-size: 2.25rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.033em;
        }
        
        .page-subtitle {
            color: #6b7280;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        @media (min-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (min-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        .stat-card {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            border-radius: 0.75rem;
            padding: 1.5rem;
            border: 1px solid #e5e7eb;
            background-color: white;
        }
        
        .stat-label {
            color: #111827;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        .stat-value {
            color: #111827;
            font-size: 1.875rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.025em;
        }
        
        .stat-change {
            color: #059669;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
        }
        
        /* Urgent Task Card */
        .urgent-task {
            margin-bottom: 2rem;
        }
        
        .urgent-card {
            display: flex;
            flex-direction: column;
            align-items: stretch;
            justify-content: flex-start;
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            background-color: rgba(249, 115, 22, 0.1);
            border: 1px solid rgba(249, 115, 22, 0.3);
            overflow: hidden;
        }
        
        @media (min-width: 1280px) {
            .urgent-card {
                flex-direction: row;
                align-items: center;
            }
        }
        
        .urgent-content {
            width: 100%;
            display: flex;
            min-width: 18rem;
            flex: 1;
            flex-direction: column;
            align-items: stretch;
            justify-content: center;
            gap: 0.5rem;
            padding: 1.5rem;
        }
        
        @media (min-width: 1280px) {
            .urgent-content {
                padding: 2rem;
            }
        }
        
        .urgent-label {
            color: #ea580c;
            font-size: 0.875rem;
            font-weight: 600;
            line-height: 1.5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .urgent-title {
            color: #111827;
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.015em;
        }
        
        .urgent-details {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
            justify-content: space-between;
            margin-top: 0.5rem;
        }
        
        @media (min-width: 640px) {
            .urgent-details {
                flex-direction: row;
                align-items: center;
                gap: 2rem;
            }
        }
        
        .urgent-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .urgent-number {
            color: #dc2626;
            font-size: 3.75rem;
            font-weight: 900;
        }
        
        .urgent-description {
            color: #4b5563;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            max-width: 20rem;
        }
        
        .urgent-button {
            display: flex;
            min-width: 84px;
            max-width: 480px;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 2.5rem;
            padding: 0 1.5rem;
            background-color: var(--primary-color);
            color: white;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.5;
            border: none;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
        }
        
        .urgent-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        /* Charts Section */
        .charts-section {
            margin-top: 2rem;
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
        }
        
        @media (min-width: 1024px) {
            .charts-section {
                grid-template-columns: 3fr 2fr;
            }
        }
        
        .chart-card {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            border-radius: 0.75rem;
            padding: 1.5rem;
            border: 1px solid #e5e7eb;
            background-color: white;
        }
        
        .chart-title {
            color: #111827;
            font-size: 1.125rem;
            font-weight: 700;
        }
        
        .chart-container {
            width: 100%;
            height: 16rem;
            background-color: #f3f4f6;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .chart-image {
            object-fit: contain;
            width: 100%;
            height: 100%;
        }
        
        .users-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .user-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
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
        
        .user-info {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            color: #111827;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .user-time {
            color: #6b7280;
            font-size: 0.75rem;
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
            
            .page-title {
                font-size: 1.875rem;
            }
            
            .urgent-content {
                padding: 1rem;
            }
            
            .urgent-number {
                font-size: 3rem;
            }
            
            .urgent-description {
                max-width: 100%;
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
                    <a class="nav-link active" href="PanelAdministrador.aspx">
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
                    <a class="nav-link" href="AdminGestionUsuario.aspx">
                        <span class="material-symbols-outlined nav-icon">group</span>
                        <p class="nav-text">Usuarios</p>
                    </a>
                    <a class="nav-link" href="AdminConfiguracionTienda.aspx">
                        <span class="material-symbols-outlined nav-icon">settings</span>
                        <p class="nav-text">Configuración</p>
                    </a>
                    <a class="nav-link" href="javascript:void(0);" onclick="alert('Funcionalidad de Mi Perfil próximamente'); return false;">
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
                    <a class="breadcrumb-link" href="#">Inicio</a>
                    <span class="breadcrumb-separator">/</span>
                    <span class="breadcrumb-current">Dashboard</span>
                </div>
                
                <!-- Page Header -->
                <header class="page-header">
                    <div class="page-title-section">
                        <h1 class="page-title">Resumen General</h1>
                        <p class="page-subtitle">Una vista general e instantánea del estado de la aplicación.</p>
                    </div>
                </header>
                
                <!-- Stats Grid -->
                <section class="stats-grid">
                    <div class="stat-card">
                        <p class="stat-label">Artículos Activos</p>
                        <p class="stat-value"><asp:Label ID="lblCantidadArticulos" runat="server" Text="0"></asp:Label></p>
                        <p class="stat-change">Total de artículos en tu tienda</p>
                    </div>
                    <div class="stat-card">
                        <p class="stat-label">Categorías</p>
                        <p class="stat-value"><asp:Label ID="lblCantidadCategorias" runat="server" Text="0"></asp:Label></p>
                        <p class="stat-change">Categorías disponibles</p>
                    </div>
                    <div class="stat-card">
                        <p class="stat-label">Reservas Pendientes</p>
                        <p class="stat-value"><asp:Label ID="lblCantidadReservas" runat="server" Text="0"></asp:Label></p>
                        <p class="stat-change">Requieren tu atención</p>
                    </div>
                    <div class="stat-card">
                        <p class="stat-label">Ventas del Mes</p>
                        <p class="stat-value"><asp:Label ID="lblCantidadVentas" runat="server" Text="0"></asp:Label></p>
                        <p class="stat-change">Ventas realizadas este mes</p>
                    </div>
                </section>
                
                <!-- Urgent Task Card -->
                <section class="urgent-task">
                    <div class="urgent-card">
                        <div class="urgent-content">
                            <p class="urgent-label">Acción Urgente</p>
                            <p class="urgent-title">Señás Pendientes de Confirmar</p>
                            <div class="urgent-details">
                                <div class="urgent-info">
                                    <p class="urgent-number"><asp:Label ID="lblReservasPendientes" runat="server" Text="0"></asp:Label></p>
                                    <p class="urgent-description">Hay <asp:Label ID="lblReservasPendientesTexto" runat="server" Text="0"></asp:Label> señas que requieren tu revisión y confirmación manual para completar las ventas.</p>
                                </div>
                                <a href="AdminConfirmarSeña.aspx" class="urgent-button text-decoration-none d-block text-center">
                                    <span>Gestionar Señás</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Charts Section -->
                <section class="charts-section">
                    <!-- Sales Chart -->
                    <div class="chart-card">
                        <h3 class="chart-title">Evolución de Ventas (Últimos 7 días)</h3>
                        <div class="chart-container">
                            <img class="chart-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDyG4vrvz1zdvc_2a3kmZMa-6irwOFtpIscsXgnD8Tycw9_VtsgATzZ6UaSzsQY25lPdPPVuyOMdPKMApbuTN2ep9ny_miBm7AXpEZaFvQBGOHl7kJrQQb-wGdCzIH4VzMVDhWnPVzKBtBgmEe0Q--TQIbKd7Qxg7pstUudV8MLrir4qgDsYpHxpPAhVOE5sC26gWcE76Y1beb85JSklZJTk7elmU06RwjkoLnRcN3cXAZyzCTMDqKtjbsJf3m2aKGr95eFLkOVXmA" alt="A line chart showing sales trends over the last 7 days, with an upward trend." />
                        </div>
                    </div>
                    
                    <!-- Recent Users -->
                    <div class="chart-card">
                        <h3 class="chart-title">Últimos Usuarios Registrados</h3>
                        <div class="users-list">
                            <div class="user-item">
                                <div class="user-avatar" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDjjpQRJq9J6bWaQqoBnwgnAtze7MulL70U099T_80rgNKdOTfBjtSl4BvtHen9ID5BRcaak3ImHCBrwTNO8u7tNT1_dkX1ThzHxXnj64wKvtCZ3ocPTMAiKppHjuJZsT4D-Nf4OnHYFyqv5Nz7JfjjYYqVPnrEHmORpJVN43tzKCPgvrWiYZHy9Ode45o9-DP-M1EmkiVoLwEiJYGZmo_cP6Ikpeh1IomL_yWhd5MSVP18sDJGsn94RVeUkCPYugBF1f_piui94NA");'></div>
                                <div class="user-info">
                                    <p class="user-name">Elena Gómez</p>
                                    <p class="user-time">Hace 2 horas</p>
                                </div>
                            </div>
                            <div class="user-item">
                                <div class="user-avatar" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDme87Qa29yknTGF5LJ210fzSyG5ntV-1Tkx-UMr1iBSJnDoeray1MovdWzmziKKrBFwLRXMEpqfrWAVLduJ8p9DIkYF-9dj1S8Lw0QEu4BOu5fQ8qZuwXkwZGeP5VoI-wGa4s4KyF98nJFy9lb4g4085Lp8AwV4W9Cd5DkBE0I1SA_CxczHJzaYiqVQMN1hFoiq5z5kxc0nwTYhfQx5rg07qdglyuaHVkxFiK7shtesNfNR6Lx8SZk2vUTUf7rt3FzmGn2q_IvJgQ");'></div>
                                <div class="user-info">
                                    <p class="user-name">Carlos Ruiz</p>
                                    <p class="user-time">Hace 5 horas</p>
                                </div>
                            </div>
                            <div class="user-item">
                                <div class="user-avatar" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCqt0V88pt_f1gw0V6HnpL7___IcyPcB6vnx4ufA6-X-YthPFskO8IrxaVkmzvNaZ4A-1eYpU5B11F-ejdwQyuDizRdded-b_dBgmPqzf7_SuZs0WfmZSBKDaeySIJC1MIBne5RJ-kiQJXEswVqWNh-ggzBlu5Eu-Sx9iIV7ubdd3CjYIXVFvyI8StOU6K1k32sFbK9mYt4_Ulh4xzF3FNsc5fmCJTN31ggeGTHcVoB1aPUImdKCE_xZFJCn7E-bTn7hXt7VGu233s");'></div>
                                <div class="user-info">
                                    <p class="user-name">Ana Fernández</p>
                                    <p class="user-time">Hace 1 día</p>
                                </div>
                            </div>
                            <div class="user-item">
                                <div class="user-avatar" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuABcn69A9jh5vnHpLQ7AETf9d3HI9RHgf0TyKrSh7U3CiaoxtA4nabi9ojMWkU2x3p8RDkWhd8MpI7xx-OKFQvn-r8zwDM06Fv2KkQPwj0hctbcob3B4x_rlTGbZ24EmU3F7b13bF-vUEt-p9a_Dmn0DF453XhHvBfBsM7BR-xgl2q6IM22MmuNq6r7h9H_9WBKNsTvv-w05x36pI9v4NTUPNaRXZe7ye_s3g1pn3A664M3U3PZHnfBd0wyxtkPRGMB4OgBGbuxWBY");'></div>
                                <div class="user-info">
                                    <p class="user-name">Javier Moreno</p>
                                    <p class="user-time">Hace 2 días</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

