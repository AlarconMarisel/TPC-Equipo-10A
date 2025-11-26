<%@ Page Title="Crear Administrador" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="SuperAdminCrearAdministrador.aspx.cs" Inherits="APP_Web_Equipo10A.SuperAdminCrearAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 1.875rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6b7280;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: #1173d4;
            box-shadow: 0 0 0 3px rgba(17, 115, 212, 0.1);
        }

        .btn-submit {
            background-color: #1173d4;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #0d5ba8;
        }

        .btn-cancel {
            background-color: #6b7280;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background-color: #4b5563;
            color: white;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .text-danger {
            color: #dc2626;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .checkbox-group input[type="checkbox"] {
            width: 1.25rem;
            height: 1.25rem;
        }
        .password-input-container {
            position: relative;
            display: flex;
            width: 100%;
            flex: 1;
            align-items: center;
        }
        

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container">
        <h1 class="page-title">Crear Nuevo Administrador</h1>
        <p class="page-subtitle">Complete el formulario para crear un nuevo administrador. Se le asignarán categorías por defecto automáticamente.</p>

        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger" Visible="false"></asp:Label>

        <div class="form-group">
            <label class="form-label" for="txtNombre">Nombre <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" required="true" onkeypress="return soloLetrasYEspacios(event)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                ErrorMessage="El nombre es requerido" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtApellido">Apellido <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" required="true" onkeypress="return soloLetrasYEspacios(event)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" 
                ErrorMessage="El apellido es requerido" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtEmail">Email <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required="true"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="El email es requerido" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ErrorMessage="Email inválido" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtPassword">Contraseña <span class="text-danger">*</span></label>
            <div class="password-input-container">
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="true"></asp:TextBox>
                <button type="button" class="password-toggle" onclick="togglePassword('<%= txtPassword.ClientID %>', this)">
                    <span class="material-symbols-outlined">visibility_off</span>
                </button>
            </div>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                ErrorMessage="La contraseña es requerida" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtDNI">DNI</label>
            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" MaxLength="8" onkeypress="return soloNumeros(event)"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtTelefono">Teléfono</label>
            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" onkeypress="return soloNumeros(event)"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtDomicilio">Domicilio</label>
            <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtFechaVencimiento">Fecha de Vencimiento (Opcional)</label>
            <asp:TextBox ID="txtFechaVencimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        </div>

        <div class="form-group">
            <div class="checkbox-group">
                <asp:CheckBox ID="chkActivo" runat="server" Checked="true" />
                <label for="chkActivo" class="form-label" style="margin: 0;">Activo</label>
            </div>
            <small class="text-muted">El administrador estará activo por defecto</small>
        </div>

        <div class="btn-group">
            <asp:Button ID="btnCrear" runat="server" Text="Crear Administrador" CssClass="btn-submit" OnClick="btnCrear_Click" />
            <a href="PanelSuperAdmin.aspx" class="btn-cancel">Cancelar</a>
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


