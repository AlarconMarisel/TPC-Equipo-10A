<%@ Page Title="Iniciar Sesión" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="APP_Web_Equipo10A.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--background-light);
            padding: 1rem;
        }
        
        .login-content {
            width: 100%;
            max-width: 28rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 2rem;
            padding: 2.5rem 0;
        }
        
        .login-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            text-align: center;
        }
        
        .login-logo {
            display: flex;
            height: 4rem;
            width: 4rem;
            align-items: center;
            justify-content: center;
            border-radius: 1rem;
            background-color: var(--primary-color);
            color: white;
        }
        
        .login-logo-icon {
            font-size: 2.25rem;
        }
        
        .login-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-light);
        }
        
        .login-subtitle {
            font-size: 1rem;
            color: #6c757d;
        }
        
        .login-card {
            display: flex;
            width: 100%;
            flex-direction: column;
            border-radius: 0.75rem;
            border: 1px solid #ced4da;
            background-color: white;
            padding: 1.5rem;
        }
        
        @media (min-width: 768px) {
            .login-card {
                padding: 2rem;
            }
        }
        
        .login-form-header {
            margin-bottom: 1.5rem;
        }
        
        .login-form-title {
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.2;
            letter-spacing: -0.033em;
            color: var(--text-light);
        }
        
        .login-form-subtitle {
            color: #6c757d;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        
        .form-label {
            color: var(--text-light);
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1.5;
            padding-bottom: 0.5rem;
        }
        
        .form-input-container {
            display: flex;
            width: 100%;
            flex: 1;
            align-items: stretch;
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            transition: all 0.2s ease;
        }
        
        .form-input-container:focus-within {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .form-input {
            display: flex;
            width: 100%;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 0.5rem 0 0 0.5rem;
            color: var(--text-light);
            background-color: transparent;
            height: 48px;
            padding: 15px;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            border: none;
            outline: none;
        }
        
        .form-input::placeholder {
            color: #6c757d;
        }
        
        .form-input-icon {
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-right: 1rem;
        }
        
        .password-toggle {
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-right: 1rem;
            background: none;
            border: none;
            cursor: pointer;
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .forgot-password {
            display: flex;
            justify-content: flex-end;
        }
        
        .forgot-password-link {
            color: var(--primary-color);
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.5;
            text-decoration: underline;
        }
        
        .login-button {
            display: flex;
            min-width: 84px;
            width: 100%;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 0.5rem;
            height: 48px;
            padding: 0 1.25rem;
            background-color: var(--primary-color);
            color: white;
            font-size: 1rem;
            font-weight: 700;
            line-height: 1.5;
            letter-spacing: 0.015em;
            border: none;
            transition: all 0.1s ease;
        }
        
        .login-button:hover {
            background-color: rgba(52, 152, 219, 0.9);
        }
        
        .login-button:active {
            transform: scale(0.98);
        }
        
        .register-link {
            text-align: center;
        }
        
        .register-link-text {
            color: #6c757d;
            font-size: 1rem;
            font-weight: 400;
        }
        
        .register-link-text a {
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: underline;
        }
        
        .register-link-text a:hover {
            color: #2980b9;
        }
        
        
        :root {
            --primary-color: #3498DB;
            --background-light: #F8F9FA;
            --text-light: #343A40;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-container">
        <div class="login-content">
            <!-- Logo y Encabezado -->
            <div class="login-header">
                <div class="login-logo">
                    <span class="material-symbols-outlined login-logo-icon">shopping_bag</span>
                </div>
                <h1 class="login-title">Reventa Rápida</h1>
                <p class="login-subtitle">Tu mercado de confianza para artículos usados.</p>
            </div>
            
            <!-- Contenedor del Formulario -->
            <div class="login-card">
                <!-- Título del Formulario -->
                <div class="login-form-header">
                    <h2 class="login-form-title">Accede a tu cuenta</h2>
                    <p class="login-form-subtitle">Bienvenido de vuelta a nuestra comunidad.</p>
                </div>
                
                <!-- Formulario -->
                <form class="d-flex flex-column gap-4">
                    <!-- Campo de Email -->
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <div class="form-input-container">
                            <input type="email" class="form-input" placeholder="tu.email@ejemplo.com" />
                            <div class="form-input-icon">
                                <span class="material-symbols-outlined">mail</span>
                            </div>
                        </div>
                        <!-- Mensaje de Error (ejemplo) -->
                        <!-- <p class="text-danger small mt-1">Email no válido</p> -->
                    </div>
                    
                    <!-- Campo de Contraseña -->
                    <div class="form-group">
                        <label class="form-label">Contraseña</label>
                        <div class="form-input-container">
                            <input type="password" class="form-input" placeholder="Introduce tu contraseña" />
                            <button type="button" class="password-toggle" aria-label="Mostrar u ocultar contraseña">
                                <span class="material-symbols-outlined">visibility</span>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Enlace de Recuperar Contraseña -->
                    <div class="forgot-password">
                        <a href="#" class="forgot-password-link">Recuperar contraseña</a>
                    </div>
                    
                    <!-- Botón de Iniciar Sesión -->
                    <div class="pt-2">
                        <button type="submit" class="login-button">
                            <span>Iniciar Sesión</span>
                            <!-- Ejemplo de Spinner de Carga -->
                            <!-- <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                            </svg> -->
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Enlace de Registro -->
            <div class="register-link">
                <p class="register-link-text mb-0">
                    ¿No tienes una cuenta? <a href="Registro.aspx">Regístrate aquí</a>
                </p>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>



