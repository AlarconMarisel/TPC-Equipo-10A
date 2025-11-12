<%@ Page Title="Formulario de Categoría" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminFormularioCategoria.aspx.cs" Inherits="APP_Web_Equipo10A.AdminFormularioCategoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .admin-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            flex-direction: column;
            overflow-x: hidden;
        }
        
        .main-content {
            display: flex;
            height: 100%;
            flex: 1;
            flex-direction: column;
        }
        
        .content-wrapper {
            display: flex;
            flex: 1;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        @media (min-width: 768px) {
            .content-wrapper {
                padding: 3rem 1rem;
            }
        }
        
        @media (min-width: 1024px) {
            .content-wrapper {
                padding: 4rem 1rem;
            }
        }
        
        .form-container {
            display: flex;
            flex-direction: column;
            max-width: 48rem;
            flex: 1;
            padding: 0 1rem;
        }
        
        @media (min-width: 640px) {
            .form-container {
                padding: 0 1.5rem;
            }
        }
        
        @media (min-width: 1024px) {
            .form-container {
                padding: 0 2rem;
            }
        }
        
        /* Page Heading */
        .page-heading {
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 2.25rem;
            font-weight: 900;
            line-height: 1.2;
            letter-spacing: -0.025em;
            color: #0d141b;
        }
        
        .page-subtitle {
            margin-top: 0.5rem;
            font-size: 1.125rem;
            color: #64748b;
        }
        
        /* Form Container */
        .form-section {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        
        .form-card {
            background-color: white;
            padding: 1.5rem 2rem;
            border-radius: 0.75rem;
            border: 1px solid #cfdbe7;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        
        @media (min-width: 640px) {
            .form-card {
                padding: 2rem;
            }
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem 1.5rem;
        }
        
        .form-field {
            display: flex;
            flex-direction: column;
        }
        
        .form-field.full-width {
            grid-column: 1 / -1;
        }
        
        .form-label {
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.25;
            padding-bottom: 0.5rem;
            color: #0d141b;
        }
        
        .form-input {
            display: flex;
            width: 100%;
            min-width: 0;
            flex: 1;
            resize: none;
            overflow: hidden;
            border-radius: 0.5rem;
            color: #0d141b;
            border: 1px solid #cfdbe7;
            background-color: #f6f7f8;
            height: 3.5rem;
            padding: 0.9375rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.25;
            transition: all 0.2s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        .form-input::placeholder {
            color: #64748b;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 1rem;
            padding-top: 1rem;
        }
        
        .cancel-button {
            border-radius: 0.5rem;
            background-color: #e2e8f0;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            color: #1e293b;
            border: none;
            cursor: pointer;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .cancel-button:hover {
            background-color: #cbd5e1;
        }
        
        .cancel-button:focus {
            outline: none;
            box-shadow: 0 0 0 2px #e2e8f0, 0 0 0 4px rgba(17, 115, 212, 0.2);
        }
        
        .submit-button {
            border-radius: 0.5rem;
            background-color: var(--primary-color);
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            border: none;
            cursor: pointer;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
        }
        
        .submit-button:hover {
            background-color: rgba(17, 115, 212, 0.8);
        }
        
        .submit-button:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--primary-color), 0 0 0 4px rgba(17, 115, 212, 0.2);
        }
        
        .submit-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        @media (max-width: 640px) {
            .page-title {
                font-size: 1.875rem;
            }
            
            .form-card {
                padding: 1rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .cancel-button,
            .submit-button {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <main class="main-content">
            <div class="content-wrapper">
                <div class="form-container">
                    <!-- Page Heading -->
                    <div class="page-heading">
                        <h1 class="page-title">
                            <asp:Label ID="lblTitulo" runat="server" Text="Nueva Categoría"></asp:Label>
                        </h1>
                        <p class="page-subtitle">Completa los detalles a continuación para crear o editar una categoría.</p>
                    </div>
                    
                    <!-- Form Container -->
                    <div class="form-section">
                        <!-- Basic Information Card -->
                        <div class="form-card">
                            <div class="form-grid">
                                <!-- Category Name -->
                                <div class="form-field full-width">
                                    <label class="form-label">Nombre de la categoría</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" placeholder="Ej: Electrodomésticos"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                                        ErrorMessage="El nombre es requerido" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <asp:LinkButton ID="btnCancelar" runat="server" CssClass="cancel-button" 
                                PostBackUrl="~/AdminGestionCategoria.aspx">Cancelar</asp:LinkButton>
                            <asp:Button ID="btnGuardar" runat="server" CssClass="submit-button" Text="Guardar Categoría" OnClick="btnGuardar_Click" />
                        </div>
                        
                        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-2" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

