<%@ Page Title="Panel Super Admin" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="True" CodeBehind="PanelSuperAdmin.aspx.cs" Inherits="APP_Web_Equipo10A.PanelSuperAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            flex-direction: column;
            padding: 2rem 1rem;
        }

        @media (min-width: 768px) {
            .admin-container {
                padding: 3rem 2rem;
            }
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #111827;
            margin: 0;
        }

        .btn-crear {
            background-color: #1173d4;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-crear:hover {
            background-color: #0d5ba8;
            color: white;
        }

        .table-container {
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table {
            margin: 0;
        }

        .table thead {
            background-color: #f9fafb;
        }

        .table th {
            padding: 1rem;
            font-weight: 600;
            color: #374151;
            border-bottom: 2px solid #e5e7eb;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
        }

        .badge {
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .badge-activo {
            background-color: #d1fae5;
            color: #065f46;
        }

        .badge-inactivo {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .badge-vencido {
            background-color: #fef3c7;
            color: #92400e;
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            border: 1px solid #d1d5db;
            background-color: white;
            color: #374151;
            font-size: 0.875rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-action:hover {
            background-color: #f9fafb;
        }

        .btn-action-primary {
            background-color: #1173d4;
            color: white;
            border-color: #1173d4;
        }

        .btn-action-primary:hover {
            background-color: #0d5ba8;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #6b7280;
        }

        .empty-state-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <div class="page-header">
            <h1 class="page-title">Panel Super Administrador</h1>
            <a href="SuperAdminCrearAdministrador.aspx" class="btn-crear">
                <span class="material-symbols-outlined">add</span>
                Crear Nuevo Administrador
            </a>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvAdministradores" runat="server" CssClass="table" AutoGenerateColumns="false" 
                EmptyDataText="No hay administradores registrados" OnRowCommand="gvAdministradores_RowCommand">
                <Columns>
                    <asp:BoundField DataField="IdUsuario" HeaderText="ID" ItemStyle-Width="60px" />
                    <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="NombreTienda" HeaderText="Nombre Tienda" NullDisplayText="-" />
                    <asp:BoundField DataField="FechaAltaFormateada" HeaderText="Fecha Alta" />
                    <asp:BoundField DataField="FechaVencimientoFormateada" HeaderText="Fecha Vencimiento" NullDisplayText="Sin fecha" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:Label ID="lblEstado" runat="server" CssClass='<%# GetEstadoCssClass(Eval("Activo"), Eval("FechaVencimiento")) %>' 
                                Text='<%# GetEstadoTexto(Eval("Activo"), Eval("FechaVencimiento")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnActivarDesactivar" runat="server" 
                                CommandName="ToggleActivo" 
                                CommandArgument='<%# Eval("IdUsuario") %>'
                                CssClass="btn-action"
                                Text='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'></asp:LinkButton>
                            <asp:LinkButton ID="btnEditar" runat="server" 
                                CommandName="Editar" 
                                CommandArgument='<%# Eval("IdUsuario") %>'
                                CssClass="btn-action btn-action-primary"
                                Text="Editar"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-3" Visible="false"></asp:Label>
    </div>
</asp:Content>


