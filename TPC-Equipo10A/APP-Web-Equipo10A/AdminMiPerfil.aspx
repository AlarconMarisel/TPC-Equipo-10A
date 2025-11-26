<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="AdminMiPerfil.aspx.cs" Inherits="APP_Web_Equipo10A.AdminMiPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            flex-direction: row;
        }
        
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
        
        .main-content {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }
        
        .content-container {
            width: 100%;
            max-width: 50rem;
            margin: 0 auto;
        }
        
        .page-header {
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #6b7280;
            font-size: 1rem;
        }
        
        .profile-card {
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            font-size: 1rem;
            box-sizing: border-box;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1);
        }
        
        .form-input[readonly] {
            background-color: #f3f4f6;
            cursor: not-allowed;
        }
        
        .info-value {
            padding: 0.75rem;
            background-color: #f3f4f6;
            border-radius: 0.5rem;
            color: #374151;
            font-size: 1rem;
        }
        
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
        
        .badge-warning {
            background-color: #fef3c7;
            color: #92400e;
        }
        
        .form-help {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 0.5rem;
        }
        
        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 1rem;
        }
        
        .btn-primary:hover {
            background-color: #0f5bb8;
        }
        
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.2s;
            font-size: 1rem;
        }
        
        .btn-secondary:hover {
            background-color: #4b5563;
        }
        
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
        
        .password-input-container {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #6b7280;
            padding: 0.25rem;
        }
        
        .password-toggle:hover {
            color: #374151;
        }
        
        .link-to-config {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .link-to-config:hover {
            text-decoration: underline;
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
                    <a class="nav-link active" href="AdminMiPerfil.aspx">
                        <span class="material-symbols-outlined nav-icon">account_circle</span>
                        <p class="nav-text">Mi Perfil</p>
                    </a>
                </nav>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="content-container">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Mi Perfil</h1>
                    <p class="page-subtitle">Gestiona tu información personal y configuración de cuenta.</p>
                </div>
                
                <!-- Mensaje -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="alert" Visible="false"></asp:Label>
                
                <!-- Información de Cuenta (Solo Lectura) -->
                <div class="profile-card">
                    <h2 class="card-title">Información de Cuenta</h2>
                    
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <div class="info-value">
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">ID de Administrador</label>
                        <div class="info-value">
                            <asp:Label ID="lblIdAdministrador" runat="server"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Fecha de Alta</label>
                        <div class="info-value">
                            <asp:Label ID="lblFechaAlta" runat="server"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Fecha de Vencimiento</label>
                        <div class="info-value">
                            <asp:Label ID="lblFechaVencimiento" runat="server"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Estado de Cuenta</label>
                        <div>
                            <asp:Label ID="lblEstado" runat="server" CssClass="badge"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Nombre de Tienda</label>
                        <div class="info-value">
                            <asp:Label ID="lblNombreTiendaInfo" runat="server"></asp:Label>
                            <a href="AdminConfiguracionTienda.aspx" class="link-to-config"> (Configurar)</a>
                        </div>
                    </div>
                </div>
                
                <!-- Datos Personales (Editables) -->
                <div class="profile-card">
                    <h2 class="card-title">Datos Personales</h2>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtNombre">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                            ErrorMessage="El nombre es requerido" CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="DatosPersonales"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtApellido">Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-input" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" 
                            ErrorMessage="El apellido es requerido" CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="DatosPersonales"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtDNI">DNI</label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-input" MaxLength="15"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtTelefono">Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-input" MaxLength="20"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtDomicilio">Domicilio</label>
                        <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-input" MaxLength="100"></asp:TextBox>
                    </div>
                    
                    <div class="btn-group">
                        <asp:Button ID="btnGuardarDatos" runat="server" Text="Guardar Cambios" CssClass="btn-primary" OnClick="btnGuardarDatos_Click" ValidationGroup="DatosPersonales" />
                    </div>
                </div>
                
                <!-- Cambio de Contraseña -->
                <div class="profile-card">
                    <h2 class="card-title">Cambiar Contraseña</h2>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtPasswordActual">Contraseña Actual</label>
                        <div class="password-input-container">
                            <asp:TextBox ID="txtPasswordActual" runat="server" TextMode="Password" CssClass="form-input" MaxLength="20"></asp:TextBox>
                            <button type="button" class="password-toggle" onclick="togglePassword('<%= txtPasswordActual.ClientID %>', this)">
                                <span class="material-symbols-outlined">visibility_off</span>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPasswordActual" runat="server" ControlToValidate="txtPasswordActual" 
                            ErrorMessage="La contraseña actual es requerida" CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="CambiarPassword"></asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtPasswordNuevo">Nueva Contraseña</label>
                        <div class="password-input-container">
                            <asp:TextBox ID="txtPasswordNuevo" runat="server" TextMode="Password" CssClass="form-input" MaxLength="20"></asp:TextBox>
                            <button type="button" class="password-toggle" onclick="togglePassword('<%= txtPasswordNuevo.ClientID %>', this)">
                                <span class="material-symbols-outlined">visibility_off</span>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPasswordNuevo" runat="server" ControlToValidate="txtPasswordNuevo" 
                            ErrorMessage="La nueva contraseña es requerida" CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="CambiarPassword"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revPasswordNuevo" runat="server" ControlToValidate="txtPasswordNuevo" 
                            ValidationExpression=".{8,}" ErrorMessage="La contraseña debe tener al menos 8 caracteres" 
                            CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="CambiarPassword"></asp:RegularExpressionValidator>
                        <p class="form-help">La contraseña debe tener al menos 8 caracteres.</p>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="txtPasswordConfirmar">Confirmar Nueva Contraseña</label>
                        <div class="password-input-container">
                            <asp:TextBox ID="txtPasswordConfirmar" runat="server" TextMode="Password" CssClass="form-input" MaxLength="20"></asp:TextBox>
                            <button type="button" class="password-toggle" onclick="togglePassword('<%= txtPasswordConfirmar.ClientID %>', this)">
                                <span class="material-symbols-outlined">visibility_off</span>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPasswordConfirmar" runat="server" ControlToValidate="txtPasswordConfirmar" 
                            ErrorMessage="Debe confirmar la nueva contraseña" CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="CambiarPassword"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPasswordConfirmar" runat="server" ControlToValidate="txtPasswordConfirmar" 
                            ControlToCompare="txtPasswordNuevo" ErrorMessage="Las contraseñas no coinciden" 
                            CssClass="alert alert-danger" Display="Dynamic" ValidationGroup="CambiarPassword"></asp:CompareValidator>
                    </div>
                    
                    <div class="btn-group">
                        <asp:Button ID="btnCambiarPassword" runat="server" Text="Cambiar Contraseña" CssClass="btn-primary" OnClick="btnCambiarPassword_Click" ValidationGroup="CambiarPassword" />
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        function togglePassword(inputId, button) {
            var input = document.getElementById(inputId);
            var icon = button.querySelector('.material-symbols-outlined');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.textContent = 'visibility';
            } else {
                input.type = 'password';
                icon.textContent = 'visibility_off';
            }
        }
    </script>
</asp:Content>

