<%@ Page Title="Registro de Usuario" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="Registro.aspx.cs" Inherits="APP_Web_Equipo10A.Registro" %>

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
            max-width: 70rem;
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
        .validacion {
            color: red;
            font-size: 14px;
            margin: 0;
            padding: 0;
            min-height: 0;

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
                        <h1 class="register-title mb-0">Crea tu Cuenta para Empezar a Comprar</h1>
+                        <p class="register-subtitle mb-0">Es rápido, fácil y seguro.</p>
                    </div>
                    
                    <!-- Registracion Form -->
                    <div class="d-flex flex-column gap-4">
                        <!-- Nombre y Apellido Fields Row -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" class="form-input" placeholder="Ingresar Nombre" onkeypress="return soloLetrasYEspacios(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="validacion"  ErrorMessage="Campo requerido!" ControlToValidate="txtNombre" runat="server" />
                            </div>
                            <div class="form-group">
                                <label class="form-label">Apellido</label>
                                <asp:TextBox ID="txtApellido" runat="server" class="form-input" placeholder="Ingresar Apellido" onkeypress="return soloLetrasYEspacios(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="validacion"  ErrorMessage="Campo requerido!" ControlToValidate="txtApellido" runat="server" />
                            </div>
                        </div>
                        <!-- DNI - Telefono Fields Row -->
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">DNI</label>
                                <asp:TextBox ID="txtDNI" runat="server" class="form-input" placeholder="Ingresar DNI" MaxLength="8" onkeypress="return soloNumeros(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="validacion"  ErrorMessage="Campo requerido!" ControlToValidate="txtDNI" runat="server" />
                        </div>
                            <div class="form-group">
                                <label class="form-label">Telefono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" class="form-input" placeholder="Ingresar telefono" onkeypress="return soloNumeros(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="validacion"  ErrorMessage="Campo requerido!" ControlToValidate="txtTelefono" runat="server" />
                            </div>
                        </div>
                        <!-- Domicilio Field -->
                        <div class="form-group">
                            <label class="form-label">Domicilio</label>
                               <asp:TextBox ID="txtDomicilio" runat="server" class="form-input" placeholder="Ingresar Domicilio"></asp:TextBox>
                               <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Campo requerido!" ControlToValidate="txtDomicilio" runat="server" />
                        </div>
                        <!-- Email Field -->
                        <div class="form-group">
                            <label class="form-label">Dirección de Email</label>
                            <div class="form-input">
                               <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control email-input" placeholder="Ingresar email@ejemplo.com"></asp:TextBox>
                               <asp:RegularExpressionValidator CssClass="validacion" ErrorMessage="Formato de email inválido" ControlToValidate="txtEmail" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" runat="server" />
                            </div>
                               <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Campo requerido!" ControlToValidate="txtEmail" runat="server" />
                        </div>
                        
                        <div class="form-row">
                        <!-- Contraseña Field -->
                        <div class="form-group">
                            <label class="form-label">Contraseña</label>
                            <div class="password-input-container">
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Mínimo 8 caracteres" style="padding-right: 40px;"></asp:TextBox>
                                <button type="button" class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>', this)">
                                    <span class="material-symbols-outlined">visibility_off</span>
                                </button>
                            </div>
                            <div>
                            <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Campo requerido!" ControlToValidate="txtPassword" runat="server" />
                            </div>
                        </div>                
                        <!-- Confirmacion Contraseña Field -->
                        <div class="form-group">
                            <label class="form-label">Confirmar Contraseña</label>
                            <div class="password-input-container">
                                <asp:TextBox ID="txtConfirmarPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Vuelve a introducir la contraseña" style="padding-right: 40px;"></asp:TextBox>
                                <button type="button" class="password-toggle" onclick="togglePassword('<%= txtConfirmarPassword.ClientID %>', this)">
                                    <span class="material-symbols-outlined">visibility_off</span>
                                </button>   
                            </div>
                            <div>
                            <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Campo requerido!" ControlToValidate="txtConfirmarPassword" runat="server" />
                            <asp:CompareValidator CssClass="validacion" ErrorMessage="Las contraseñas no coinciden" ControlToValidate="txtConfirmarPassword" ControlToCompare="txtPassword" runat="server" />
                            </div>
                        </div>
                       </div>
                        
                        <!-- Terms Checkbox -->
                        <div class="checkbox-container">
                            <div>
                            <label class="checkbox-label" for="terms-checkbox">
                            <asp:Checkbox runat="server" id="chkTerminos"/>
                                Acepto los Términos y Condiciones y la Política de Privacidad.
                            </label>
                            </div>
                            <div>
                                <asp:Label ID="lblMensaje" runat="server" CssClass="validacion" Visible="false"></asp:Label>
                            </div>
                        </div>
                        
                        <!-- Submit Button -->
                        <button type="submit" ID="btnRegistrar" runat="server" class="register-button" onserverclick="btnRegistrar_Click">
                            <span class="material-symbols-outlined">person_add</span> Registrarse
                        </button>
                    </div>
                    
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

        <script type="text/javascript">
        var timeoutId;
        
        function soloNumeros(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function soloLetrasYEspacios(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode > 31 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode !== 32 && charCode !== 241 && charCode !== 209) {
                return false;
            }
            return true;
        }

        var timeoutValidacionDNI;

        function validarDNIOnInput(input) {
            if (timeoutValidacionDNI) {
                clearTimeout(timeoutValidacionDNI);
            }
            
            timeoutValidacionDNI = setTimeout(function() {
                validarDNIOnBlur(input);
            }, 2000);
        }

        function togglePassword(textBoxId, button) {
            var textBox = document.getElementById(textBoxId);
            var icon = button.querySelector('.material-symbols-outlined');
            if (textBox.type === 'password') {
                textBox.type = 'text';
                icon.textContent = 'visibility';
            } else {
                textBox.type = 'password';
                icon.textContent = 'visibility_off';
            }
        }
        </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>
