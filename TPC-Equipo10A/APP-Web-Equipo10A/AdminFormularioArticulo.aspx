<%@ Page Title="Publicar Artículo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AdminFormularioArticulo.aspx.cs" Inherits="APP_Web_Equipo10A.AdminFormularioArticulo" %>

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
        
        @media (min-width: 640px) {
            .form-grid {
                grid-template-columns: 1fr 1fr;
            }
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
        
        .form-textarea {
            min-height: 9rem;
            resize: vertical;
        }
        
        .form-select {
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
        
        .form-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        .price-input-container {
            position: relative;
        }
        
        .price-symbol {
            pointer-events: none;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            display: flex;
            align-items: center;
            padding-left: 1rem;
            color: #64748b;
            font-size: 0.875rem;
        }
        
        .price-input {
            padding-left: 2.5rem;
        }
        
        /* Image Upload Section */
        .image-upload-card {
            background-color: white;
            padding: 1.5rem 2rem;
            border-radius: 0.75rem;
            border: 1px solid #cfdbe7;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        
        @media (min-width: 640px) {
            .image-upload-card {
                padding: 2rem;
            }
        }
        
        .image-upload-title {
            font-size: 1.125rem;
            font-weight: 500;
            line-height: 1.25;
            color: #0d141b;
        }
        
        .image-upload-area {
            margin-top: 1rem;
            display: flex;
            justify-content: center;
            border-radius: 0.5rem;
            border: 2px dashed #cfdbe7;
            padding: 1.5rem 1.5rem 2.5rem;
        }
        
        .upload-content {
            text-align: center;
        }
        
        .upload-icon {
            font-size: 3rem;
            color: #94a3b8;
            margin: 0 auto;
        }
        
        .upload-text {
            margin-top: 1rem;
            display: flex;
            font-size: 0.875rem;
            line-height: 1.25;
            color: #64748b;
        }
        
        .upload-link {
            position: relative;
            cursor: pointer;
            border-radius: 0.375rem;
            font-weight: 600;
            color: var(--primary-color);
            transition: all 0.2s ease;
        }
        
        .upload-link:hover {
            color: rgba(17, 115, 212, 0.8);
        }
        
        .upload-link:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.5);
        }
        
        .upload-input {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }
        
        .upload-description {
            font-size: 0.75rem;
            line-height: 1.25;
            color: #6b7280;
        }
        
        /* Image Previews */
        .image-previews {
            margin-top: 1.5rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        
        @media (min-width: 640px) {
            .image-previews {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        @media (min-width: 768px) {
            .image-previews {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        
        @media (min-width: 1024px) {
            .image-previews {
                grid-template-columns: repeat(5, 1fr);
            }
        }
        
        .image-preview {
            position: relative;
            display: flex;
            flex-direction: column;
        }
        
        .preview-image {
            aspect-ratio: 1;
            width: 100%;
            border-radius: 0.5rem;
            object-fit: cover;
        }
        
        .remove-button {
            position: absolute;
            top: 0.25rem;
            right: 0.25rem;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 0.25rem;
            border-radius: 50%;
            color: white;
            opacity: 0;
            transition: opacity 0.2s ease;
            border: none;
            cursor: pointer;
        }
        
        .image-preview:hover .remove-button {
            opacity: 1;
        }
        
        .remove-button:focus {
            opacity: 1;
            outline: none;
            box-shadow: 0 0 0 2px white;
        }
        
        .remove-icon {
            font-size: 1rem;
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
            
            .form-card,
            .image-upload-card {
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
                        <h1 class="page-title">Publica tu artículo</h1>
                        <p class="page-subtitle">Completa los detalles a continuación para poner tu artículo a la venta.</p>
                    </div>
                    
                    <!-- Form Container -->
                    <div class="form-section">
                        <!-- Basic Information Card -->
                        <div class="form-card">
                            <div class="form-grid">
                                <!-- Article Name -->
                                <div class="form-field full-width">
                                    <label class="form-label">Nombre del artículo</label>
                                    <input class="form-input" type="text" placeholder="Ej: Bicicleta de montaña casi nueva" value="" />
                                </div>
                                
                                <!-- Description -->
                                <div class="form-field full-width">
                                    <label class="form-label">Descripción</label>
                                    <textarea class="form-input form-textarea" placeholder="Describe detalles importantes como el estado, marca, modelo..."></textarea>
                                </div>
                                
                                <!-- Price -->
                                <div class="form-field">
                                    <label class="form-label">Precio</label>
                                    <div class="price-input-container">
                                        <div class="price-symbol">$</div>
                                        <input class="form-input price-input" type="text" placeholder="0.00" value="" />
                                    </div>
                                </div>
                                
                                <!-- Category -->
                                <div class="form-field">
                                    <label class="form-label">Categoría 
                                    <button type="button" id="btnAgregarCategoria" class="btn-primary ms-2">
                                    +
                                    </button>
                                    </label>
                                    <div>
                                        <asp:DropDownList ID="ddlCategoria" runat="server" Class="form-select"> 
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Image Upload Card -->
                        <div class="image-upload-card">
                            <h3 class="image-upload-title">Sube hasta 5 fotos</h3>
                            <div class="image-upload-area">
                                <div class="upload-content">
                                    <span class="material-symbols-outlined upload-icon">cloud_upload</span>
                                    <div class="upload-text">
                                        <label class="upload-link" for="file-upload">
                                            <span>Selecciona tus imágenes</span>
                                            <input class="upload-input" id="file-upload" multiple="" name="file-upload" type="file" />
                                        </label>
                                        <p>o arrástralas aquí</p>
                                    </div>
                                    <p class="upload-description">PNG, JPG, GIF hasta 10MB</p>
                                </div>
                            </div>
                            
                            <!-- Image Previews -->
                            <div class="image-previews">
                                <div class="image-preview">
                                    <img class="preview-image" alt="Vista previa de imagen de artículo de segunda mano" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDxSkwrtUxqfhqXtIwT8LCE6dJyYL3igdqpIKTetO2KxBsaI5XlL_qtkEPs6J7XZ65zYNNCKLUFbqkjTN33GNEaW9zWwQDuLH2u9bZc1y7oY1s0h9C8KkY5gP38xqMeTEnI5xA7cadwMPSICLirzcbPP4F32UYd9ftCEW9yIIENvDd9YlF0UIjIqot7HR6iUSGJ5DHoQEsJXtIKwLxto-GvG42E-lIKmsfuyaXB9vR_1zFwj-QM1LtvEbjW3maW_Xr6yPZoZbI0ZAA" />
                                    <button class="remove-button">
                                        <span class="material-symbols-outlined remove-icon">close</span>
                                    </button>
                                </div>
                                <div class="image-preview">
                                    <img class="preview-image" alt="Vista previa de imagen de artículo de segunda mano" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDpEtKypbhRxmFh1uydRD0PFoeNgmbuCWQ-N6DwzMz3RIT9R9da0Ckr-wzMsvE4w7MGAJDQC0F30rrC_mAfdKheFfHaCEwhyagNyKFTFjjNmJvkwARGwoL4b6F9dHzPjDb9TXjcwguLkSAYTApK_T1up5HJmCa4pqfszPqENcxuVDqI4l82MtR_ghX0Jqw9DAOXQPmmH510j8PbyiBHqA7I32r2mWaqxjABY2EMTM-_FPtJ6mnrmb5tIMyq8Pt07FIkFZciwO300PI" />
                                    <button class="remove-button">
                                        <span class="material-symbols-outlined remove-icon">close</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="AdminGestionArticulo.aspx" class="cancel-button text-decoration-none d-inline-block text-center">Cancelar</a>
                        <button class="submit-button" type="submit">Publicar Artículo</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>

