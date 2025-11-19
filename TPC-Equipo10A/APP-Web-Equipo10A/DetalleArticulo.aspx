<%@ Page Title="Detalle del Producto" Language="C#"
    MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true"
    CodeBehind="DetalleArticulo.aspx.cs"
    Inherits="APP_Web_Equipo10A.DetalleArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
    .product-gallery-main {
        width: 100%;
        max-width: 450px; /* límite máximo para pantallas grandes */
        height: auto;
        object-fit: contain;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
        display: block;
    }

    .product-gallery-thumb {
        width: 80px;
        height: 80px;
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s ease;
        border: 2px solid transparent;
        margin: 0 auto;
    }

    .product-gallery-thumb:hover {
        opacity: 1;
        transform: scale(1.02);
    }

    .product-gallery-thumb.active {
        border-color: var(--primary-color);
        opacity: 1;
    }

    .product-gallery-thumb:not(.active) {
        opacity: 0.7;
    }

    .breadcrumb-item {
        font-size: 14px;
        font-weight: 500;
    }

    .breadcrumb-item:not(:last-child) {
        color: #6b7280;
    }

    .breadcrumb-item:last-child {
        color: var(--text-light);
    }

    .product-title {
        font-size: 2.5rem;
        font-weight: 900;
        line-height: 1.2;
        letter-spacing: -0.033em;
    }

    .product-price {
        font-size: 2rem;
        font-weight: 700;
        line-height: 1.2;
    }

    .product-description {
        font-size: 16px;
        line-height: 1.6;
        color: #6b7280;
    }

    .cta-button {
        height: 56px;
        font-size: 18px;
        font-weight: 700;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .cta-button:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(17, 115, 212, 0.3);
    }

    .related-item {
        min-width: 240px;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    .related-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .product-card {
        transition: all 0.3s ease;
        border-radius: 12px;
    }

    .product-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15) !important;
    }

    .product-image {
        width: 100%;
        height: 250px;
        object-fit: cover;
        object-position: center;
        display: block;
        background-color: #f8fafc;
        border-radius: 12px;
    }

    .product-card:hover .product-image {
        transform: scale(1.05);
    }

    .product-description {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        line-height: 1.4;
        max-height: 2.8em;
    }

    .detail-search-input {
        height: 40px;
        padding-left: 40px;
        border-radius: 9999px;
        border: 1px solid #d1d5db;
        background-color: #f3f4f6;
    }

    .detail-search-input:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 2px rgba(17, 115, 212, 0.2);
        background-color: white;
    }

    .detail-search-icon {
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
    }

    .nav-link {
        font-size: 14px;
        font-weight: 500;
        color: #6b7280;
        transition: color 0.2s ease;
    }

    .nav-link:hover {
        color: var(--primary-color) !important;
    }

    .separator {
        border-top: 1px solid #e5e7eb;
        margin: 3rem 0;
    }

    .unique-badge {
        color: var(--primary-color);
        font-size: 16px;
        font-weight: 600;
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Breadcrumbs -->
        <nav class="mb-4">
            <div class="d-flex flex-wrap gap-2">
                <a href="Default.aspx" class="breadcrumb-item text-decoration-none">Inicio</a>
                <span class="breadcrumb-item">//</span>
                <asp:HyperLink ID="lnkCategoria" runat="server" CssClass="breadcrumb-item text-decoration-none"></asp:HyperLink>
            </div>
        </nav>
        
        <!-- Product Content -->
        <div class="row justify-content-center">
            <!-- Image Gallery -->
            <div class="col-lg-6">
                <div class="d-flex flex-column gap-3">
                    <!-- Main Image -->
                    <asp:Image ID="imgPrincipal" runat="server" CssClass="product-gallery-main" />
                    
                    <!-- Thumbnail Gallery -->
                    <div class="row g-2">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <div class="col">
                                    <div class="product-gallery-thumb"
                                        style="background-image: url('<%# ResolveUrl(Eval("RutaImagen").ToString()) %>');"
                                        onclick="document.getElementById('<%= imgPrincipal.ClientID %>').src = '<%# ResolveUrl(Eval("RutaImagen").ToString()) %>';">
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-lg-6">
                <div class="d-flex flex-column h-100 py-4">
                    <!-- Product Title and Badge -->
                    <div class="d-flex flex-wrap justify-content-between gap-3 mb-3">
                        <div class="d-flex flex-column gap-2">
                            <h1 class="product-title text-dark mb-0">
                                <asp:Label ID="lblNombre" runat="server" />
                            </h1>
                            <p class="unique-badge mb-0">¡Única unidad disponible!</p>

                            <p class="product-price text-dark mb-4">
                                <asp:Label ID="lblPrecio" runat="server" />
                            </p>
                            <div class="product-description mb-4">
                                <asp:Label ID="lblDescripcion" runat="server" />
                            </div>
                        </div>
                    </div>
                    <!-- CTA Button -->
                    <div class="mt-auto pt-4">
                        <asp:LinkButton ID="btnAgregarCarrito"
                            runat="server"
                            CssClass="btn btn-primary cta-button w-100 w-md-auto d-flex align-items-center justify-content-center gap-2 text-decoration-none"
                            OnClick="btnAgregarCarrito_Click">
                            <span class="material-symbols-outlined">add_shopping_cart</span>
                            <span>Agregar al Carrito</span>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- Separator -->
        <div class="separator"></div>

        <!-- Te puede Interesar -->
        <div class="row justify-content-center">
            <div class="col-12">
                <h3 class="h2 fw-bold mb-4 text-center">Te puede Interesar</h3>
                <div class="row g-4 justify-content-center">
                    <asp:Repeater ID="rptTePuedeInteresar" runat="server">
                        <ItemTemplate>
                            <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                                <div class="card product-card h-100 border-0 shadow-sm">
                                    <div class="position-relative overflow-hidden">
                                        <a href='DetalleArticulo.aspx?id=<%# Eval("IdArticulo") %>' class="text-decoration-none">
                                            <img src='<%# 
    (Eval("Imagenes") != null && ((List<Dominio.Imagen>)Eval("Imagenes")).Count > 0)
        ? ResolveUrl(((List<Dominio.Imagen>)Eval("Imagenes"))[0].RutaImagen)
        : "https://via.placeholder.com/600x600?text=Sin+Imagen" 
%>'
                                                alt='<%# Eval("Nombre") %>'
                                                class="card-img-top product-image" />
                                        </a>
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title fw-semibold"><%# Eval("Nombre") %></h5>
                                        <asp:Panel runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("Descripcion")?.ToString()) %>'>
                                            <p class="text-muted small mb-2 product-description"><%# Eval("Descripcion") %></p>
                                        </asp:Panel>
                                        <p class="card-text h4 fw-bold text-primary mb-3">
                                            $<%# string.Format("{0:N0}", Eval("Precio")) %>
                                        </p>
                                        <a href='DetalleArticulo.aspx?id=<%# Eval("IdArticulo") %>'
                                            class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>