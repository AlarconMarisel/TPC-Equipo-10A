<%@ Page Title="Registro de Usuario" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="APP_Web_Equipo10A.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--background-light);
            padding: 1rem;
        }
        
        .register-card {
            width: 100%;
            max-width: 28rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background-color: white;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        @media (min-width: 768px) {
            .register-card {
                padding: 2.5rem;
            }
        }
        
        .register-logo {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            padding: 2.5rem 0;
        }
        
        .register-logo-icon {
            font-size: 3rem;
            color: var(--primary-color);
        }
        
        .register-logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
        }
        
        .register-title {
            font-size: 1.875rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.033em;
            color: #0d141b;
            text-align: center;
        }
        
        @media (min-width: 768px) {
            .register-title {
                font-size: 2.25rem;
            }
        }
        
        .register-subtitle {
            color: #4c739a;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            text-align: center;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        
        .form-label {
            color: #0d141b;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.5;
            padding-bottom: 0.5rem;
        }
        
        .form-input {
            display: flex;
            width: 100%;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 8px;
            color: #0d141b;
            border: 1px solid #cfdbe7;
            background-color: var(--background-light);
            height: 48px;
            padding: 15px;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            transition: all 0.2s ease;
        }
        
        .form-input:focus {
            outline: 0;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.2);
        }
        
        .form-input::placeholder {
            color: #4c739a;
        }
        
        .password-input-container {
            position: relative;
            display: flex;
            width: 100%;
            flex: 1;
            align-items: center;
        }
        
        .password-toggle {
            position: absolute;
            right: 12px;
            color: #4c739a;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .checkbox-container {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
        }
        
        .form-checkbox {
            margin-top: 0.25rem;
            height: 20px;
            width: 20px;
            border-radius: 4px;
            border: 1px solid #cbd5e1;
            background-color: var(--background-light);
        }
        
        .form-checkbox:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .checkbox-label {
            font-size: 0.875rem;
            color: #64748b;
            line-height: 1.5;
        }
        
        .checkbox-label a {
            font-weight: 600;
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .checkbox-label a:hover {
            text-decoration: underline;
        }
        
        .register-button {
            display: flex;
            height: 48px;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            border-radius: 8px;
            background-color: var(--primary-color);
            padding: 0 1.5rem;
            font-size: 1rem;
            font-weight: 700;
            color: white;
            border: none;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
            cursor: pointer;
        }
        
        .register-button:hover {
            background-color: #0f5bb8;
            transform: translateY(-1px);
        }
        
        .register-button:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--primary-color), 0 0 0 4px rgba(17, 115, 212, 0.2);
        }
        
        .register-button:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }
        
        .login-link {
            text-align: center;
        }
        
        .login-link-text {
            font-size: 0.875rem;
            color: #64748b;
        }
        
        .login-link-text a {
            font-weight: 600;
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .login-link-text a:hover {
            text-decoration: underline;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
        }
        
        @media (min-width: 768px) {
            .form-row {
                grid-template-columns: 1fr 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="register-container">
        <div class="d-flex flex-column align-items-center">
            <!-- Logo Section -->
            <div class="register-logo">
                <span class="material-symbols-outlined register-logo-icon">shopping_bag</span>
                <p class="register-logo-text mb-0">Marketplace</p>
            </div>
            
            <!-- Registration Card -->
            <div class="register-card">
                <div class="d-flex flex-column gap-4">
                    <!-- Header -->
                    <div class="d-flex flex-column gap-3 text-center">
                        <h1 class="register-title mb-0">Crea tu Cuenta para Empezar a Comprar y Vender</h1>
                        <p class="register-subtitle mb-0">Es rápido, fácil y seguro.</p>
                    </div>
                    
                    <!-- Registration Form -->
                    <form class="d-flex flex-column gap-4">
                        <!-- Name Fields Row -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Nombre</label>
                                <input type="text" class="form-input" placeholder="Introduce tu nombre" />
                            </div>
                            <div class="form-group">
                                <label class="form-label">Apellido</label>
                                <input type="text" class="form-input" placeholder="Introduce tu apellido" />
                            </div>
                        </div>
                        
                        <!-- Email Field -->
                        <div class="form-group">
                            <label class="form-label">Dirección de Email</label>
                            <input type="email" class="form-input" placeholder="email@ejemplo.com" />
                        </div>
                        
                        <!-- Password Field -->
                        <div class="form-group">
                            <label class="form-label">Contraseña</label>
                            <div class="password-input-container">
                                <input type="password" class="form-input" placeholder="Mínimo 8 caracteres" style="padding-right: 40px;" />
                                <button type="button" class="password-toggle">
                                    <span class="material-symbols-outlined">visibility</span>
                                </button>
                            </div>
                        </div>
                        
                        <!-- Confirm Password Field -->
                        <div class="form-group">
                            <label class="form-label">Confirmar Contraseña</label>
                            <div class="password-input-container">
                                <input type="password" class="form-input" placeholder="Vuelve a introducir la contraseña" style="padding-right: 40px;" />
                                <button type="button" class="password-toggle">
                                    <span class="material-symbols-outlined">visibility_off</span>
                                </button>
                            </div>
                        </div>
                        
                        <!-- Terms Checkbox -->
                        <div class="checkbox-container">
                            <input type="checkbox" class="form-checkbox" id="terms-checkbox" />
                            <label class="checkbox-label" for="terms-checkbox">
                                Acepto los <a href="#">Términos y Condiciones</a> y la <a href="#">Política de Privacidad</a>.
                            </label>
                        </div>
                        
                        <!-- Submit Button -->
                        <button type="submit" class="register-button">
                            <span class="material-symbols-outlined">person_add</span>
                            Registrarse
                        </button>
                    </form>
                    
                    <!-- Login Link -->
                    <div class="login-link">
                        <p class="login-link-text mb-0">
                            ¿Ya eres miembro?
                            <a href="Login.aspx">Inicia sesión aquí</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>
