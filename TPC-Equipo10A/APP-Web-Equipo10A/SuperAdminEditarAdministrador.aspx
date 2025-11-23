<%@ Page Title="Editar Administrador" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="SuperAdminEditarAdministrador.aspx.cs" Inherits="APP_Web_Equipo10A.SuperAdminEditarAdministrador" %>

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

        .info-section {
            background-color: #f9fafb;
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
        }

        .info-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.25rem;
        }

        .info-value {
            color: #6b7280;
            margin-bottom: 1rem;
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

        .form-control[readonly] {
            background-color: #f3f4f6;
            cursor: not-allowed;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container">
        <h1 class="page-title">Editar Administrador</h1>
        <p class="page-subtitle">Puede modificar el estado y la fecha de vencimiento del administrador.</p>

        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger" Visible="false"></asp:Label>

        <!-- Información de solo lectura -->
        <div class="info-section">
            <div class="info-label">Nombre</div>
            <div class="info-value">
                <asp:Label ID="lblNombre" runat="server"></asp:Label>
            </div>

            <div class="info-label">Apellido</div>
            <div class="info-value">
                <asp:Label ID="lblApellido" runat="server"></asp:Label>
            </div>

            <div class="info-label">Email</div>
            <div class="info-value">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </div>

            <div class="info-label">Fecha de Alta</div>
            <div class="info-value">
                <asp:Label ID="lblFechaAlta" runat="server"></asp:Label>
            </div>
        </div>

        <!-- Campos editables -->
        <div class="form-group">
            <div class="checkbox-group">
                <asp:CheckBox ID="chkActivo" runat="server" />
                <label for="chkActivo" class="form-label" style="margin: 0;">Activo</label>
            </div>
            <small class="text-muted">Marque esta opción para activar o desactivar el administrador</small>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtFechaVencimiento">Fecha de Vencimiento</label>
            <asp:TextBox ID="txtFechaVencimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <small class="text-muted">Deje vacío si no desea establecer una fecha de vencimiento</small>
        </div>

        <asp:HiddenField ID="hdnIdAdministrador" runat="server" />

        <div class="btn-group">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn-submit" OnClick="btnGuardar_Click" />
            <a href="PanelSuperAdmin.aspx" class="btn-cancel">Cancelar</a>
        </div>
    </div>
</asp:Content>


