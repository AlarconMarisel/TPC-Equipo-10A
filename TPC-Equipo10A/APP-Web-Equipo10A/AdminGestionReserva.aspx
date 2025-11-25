<%@ Page Title="Gestión de Ventas" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="AdminGestionReserva.aspx.cs" Inherits="APP_Web_Equipo10A.AdminGestionReserva" %>

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
        
        .layout-container {
            display: flex;
            height: 100%;
            flex: 1;
            flex-direction: column;
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
        
        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }
        
        .content-container {
            display: flex;
            flex-direction: column;
            width: 100%;
            max-width: 64rem;
            flex: 1;
        }
        
        /* Page Title */
        .page-title-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            padding: 1rem;
        }
        
        .page-title {
            color: #111827;
            font-size: 2.25rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.033em;
            min-width: 18rem;
        }
        
        /* Main Card */
        .main-card {
            background-color: white;
            border-radius: 0.75rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        
        /* Section */
        .section {
            display: flex;
            flex-direction: column;
        }
        
        .section-title {
            color: #111827;
            font-size: 1.375rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.015em;
            padding: 0 1rem 0.75rem 1rem;
            padding-top: 1.25rem;
        }
        
        .section-content {
            padding: 0 1rem 0.75rem 1rem;
        }
        
        /* Search Input */
        .search-container {
            display: flex;
            flex-direction: column;
            min-width: 10rem;
            height: 3rem;
            width: 130%;
        }
        
        .search-wrapper {
            display: flex;
            width: 100%;
            flex: 1;
            align-items: stretch;
            border-radius: 0.5rem;
            height: 100%;
            position: relative;
            background-color: #f6f7f8;
            border: 1px solid #d1d5db;
            overflow: hidden; 
        }
        
        .search-icon-container {
            display: flex;
            align-items: center;
            color: #6b7280;
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            padding-left: 14px;
            padding-right: 8px;
            background-color: #f6f7f8; 
            pointer-events: none;
            z-index: 1;
        }
        
        .search-icon {
            font-size: 1.5rem;
        }
        
        .reserve-search-input {
            display: flex;
            width: 100%;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 0.5rem;
            color: #111827;
            border: none;
            background-color: transparent;
            height: 100%;
            padding: 0 1rem 0 3rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.25;
            transition: all 0.2s ease;
        }
        
        .reserve-search-input:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        .reserve-search-input::placeholder {
            color: #6b7280;
        }
        
        /* Details Grid */
        .details-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
        }
        
        @media (min-width: 768px) {
            .details-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        .detail-card {
            background-color: #f6f7f8;
            padding: 1rem;
            border-radius: 0.5rem;
        }
        
        .detail-label {
            font-size: 0.875rem;
            font-weight: 500;
            color: #6b7280;
        }
        
        .detail-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1f2937;
        }
        
        /* Articles Section */
        .articles-title {
            color: #111827;
            font-size: 1.25rem;
            font-weight: 700;
            padding: 0 1rem 1rem;
        }
        
        .articles-container {
            overflow-x: auto;
            padding: 0 1rem;
        }
        
        .articles-table {
            width: 100%;
            min-width: 37.5rem;
            vertical-align: middle;
        }
        
        .articles-header {
            overflow: hidden;
        }
        
        .articles-header-row {
            display: grid;
            grid-template-columns: 3fr 1fr 2fr;
            gap: 1rem;
            padding: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            color: #6b7280;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .articles-body {
            border-top: 1px solid #e5e7eb;
        }
        
        .article-row {
            display: grid;
            grid-template-columns: 3fr 1fr 2fr;
            gap: 1rem;
            align-items: center;
            padding: 0.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .article-row:last-child {
            border-bottom: none;
        }
        
        .article-row.disabled {
            opacity: 0.5;
            background-color: #f6f7f8;
        }
        
        .article-name {
            font-weight: 500;
            color: #1f2937;
        }
        
        .article-price {
            text-align: right;
            color: #374151;
        }
        
        .article-actions {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .action-button {
            flex: 1;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .confirm-button {
            background-color: #16a34a;
        }
        
        .confirm-button:hover {
            background-color: #15803d;
        }
        
        .reject-button {
            background-color: #dc2626;
        }
        
        .reject-button:hover {
            background-color: #b91c1c;
        }
        
        .sold-status {
            font-size: 0.875rem;
            font-weight: 600;
            color: #16a34a;
        }
        
        /* Payment Section */
        .payment-section {
            border-top: 1px solid #e5e7eb;
            padding-top: 1.5rem;
        }
        
        .payment-title {
            color: #111827;
            font-size: 1.25rem;
            font-weight: 700;
            padding: 0 1rem 1rem;
        }
        
        .payment-content {
            padding: 0 1rem;
        }
        
        .form-group {
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: #4b5563;
            margin-bottom: 0.5rem;
        }
        
        .form-select {
            display: block;
            width: 100%;
            border-radius: 0.5rem;
            border: 1px solid #d1d5db;
            background-color: white;
            color: #111827;
            padding: 0.5rem 0.75rem;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }
        
        .form-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1);
        }
        
        /* Final Button */
        .final-button-container {
            display: flex;
            justify-content: flex-end;
            padding-top: 1.5rem;
            padding: 0 1rem;
        }
        
        .final-button {
            background-color: var(--primary-color);
            color: white;
            font-weight: 700;
            padding: 0.75rem 2rem;
            border-radius: 0.5rem;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            width: 100%;
        }
        
        .final-button:hover {
            background-color: rgba(17, 115, 212, 0.9);
        }
        
        @media (min-width: 640px) {
            .final-button {
                width: auto;
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
                min-height: auto;
            }
            
            .main-content {
                padding: 1rem;
            }
            
            .page-title {
                font-size: 1.875rem;
            }
            
            .main-card {
                padding: 1rem;
            }
            
            .section-title {
                font-size: 1.25rem;
            }
            
            .articles-table {
                min-width: 100%;
            }
            
            .articles-header-row,
            .article-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
            
            .article-price {
                text-align: left;
            }
            
            .article-actions {
                justify-content: flex-start;
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
                    <a class="nav-link" href="AdminGestionArticulo.aspx">
                        <span class="material-symbols-outlined nav-icon">inventory_2</span>
                        <p class="nav-text">Artículos</p>
                    </a>
                    <a class="nav-link" href="AdminGestionCategoria.aspx">
                        <span class="material-symbols-outlined nav-icon">category</span>
                        <p class="nav-text">Categorías</p>
                    </a>
                    <a class="nav-link active" href="AdminGestionReserva.aspx">
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
        
        <div class="layout-container">
            <!-- Main Content -->
            <main class="main-content">
                <div class="content-container">
                    <!-- Page Title -->
                    <div class="page-title-section">
                        <p class="page-title">Finalizar Venta de Reserva</p>
                    </div>
                    
                    <!-- Main Card -->
                    <div class="main-card">
                        <!-- Search Section -->
                        <div class="section">
                            <h2 class="section-title">Buscar o Seleccionar Reserva Activa</h2>
                            <div class="section-content">
                                <label class="search-container">
                                    <div class="search-wrapper">
                                        <div class="search-icon-container">
                                            <span class="material-symbols-outlined search-icon">search</span>
                                        </div>
                                        <input class="reserve-search-input" type="text" placeholder="Buscar por nombre de cliente o código de reserva..." value="" />
                                    </div>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Details Section -->
                        <div class="section">
                            <h2 class="section-title">Detalles de la Reserva</h2>
                            <div class="section-content">
                                <div class="details-grid">
                                    <div class="detail-card">
                                        <p class="detail-label">Cliente:</p>
                                        <p class="detail-value">Ana Pérez</p>
                                    </div>
                                    <div class="detail-card">
                                        <p class="detail-label">Vence el:</p>
                                        <p class="detail-value">25 de Diciembre, 2023 - 18:00 hs</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Articles Section -->
                        <div class="section">
                            <h3 class="articles-title">Artículos en la Reserva</h3>
                            <div class="articles-container">
                                <div class="articles-table">
                                    <div class="articles-header">
                                        <div class="articles-header-row">
                                            <div>Artículo</div>
                                            <div class="text-right">Precio/Seña</div>
                                            <div class="text-center">Acciones</div>
                                        </div>
                                    </div>
                                    <div class="articles-body">
                                        <div class="article-row">
                                            <div class="article-name">Silla de Oficina Ergonómica</div>
                                            <div class="article-price">$25.000</div>
                                            <div class="article-actions">
                                                <button class="action-button confirm-button">Confirmar Venta</button>
                                                <button class="action-button reject-button">Rechazado</button>
                                            </div>
                                        </div>
                                        <div class="article-row disabled">
                                            <div class="article-name">Monitor Dell 24"</div>
                                            <div class="article-price">$15.000</div>
                                            <div class="article-actions">
                                                <span class="sold-status">Vendido</span>
                                            </div>
                                        </div>
                                        <div class="article-row">
                                            <div class="article-name">Teclado Mecánico RGB</div>
                                            <div class="article-price">$8.000</div>
                                            <div class="article-actions">
                                                <button class="action-button confirm-button">Confirmar Venta</button>
                                                <button class="action-button reject-button">Rechazado</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Section -->
                        <div class="payment-section">
                            <h3 class="payment-title">Registrar Pago del 90% Restante</h3>
                            <div class="payment-content">
                                <div class="form-group">
                                    <label class="form-label" for="payment-method">Método de Pago</label>
                                    <select class="form-select" id="payment-method" name="payment-method">
                                        <option>Efectivo</option>
                                        <option>Transferencia</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Final Button -->
                        <div class="final-button-container">
                            <button class="final-button">Finalizar Gestión de Reserva</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

