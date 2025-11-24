<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="APP_Web_Equipo10A.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .home-search-input {
            height: 56px;
            padding-left: 48px;
        }

        .home-search-icon {
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
        }

        .category-chip {
            height: 36px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            color: #212529 !important;
            background-color: white !important;
            border: 1px solid #ced4da !important;
            padding: 0.375rem 2.25rem 0.375rem 0.75rem !important;
        }

            .category-chip:hover {
                border-color: #0d6efd !important;
            }

            .category-chip:focus {
                color: #212529 !important;
                background-color: white !important;
                border-color: #0d6efd !important;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
                outline: none;
            }

            .category-chip option {
                color: #212529 !important;
                background-color: white !important;
                padding: 8px;
            }

            .category-chip option:checked,
            .category-chip option:selected {
                color: #212529 !important;
                background-color: #f8f9fa !important;
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

        .popular-badge {
            background-color: #FB5607;
            font-size: 12px;
            font-weight: bold;
            padding: 4px 8px;
            border-radius: 12px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <!-- Page Heading & Search Bar Section -->
        <section class="mb-5">
            <div class="text-center mb-4">
                <h2 class="display-4 fw-black mb-3">Encuentra lo que buscas</h2>
                <p class="fs-5 text-muted">Explora miles de artículos de segunda mano a los mejores precios.</p>
                <!-- Enlace de registro si hay tienda en la URL -->
                <asp:Panel ID="pnlRegistroTienda" runat="server" Visible="false" CssClass="mt-3">
                    <p class="text-muted mb-2">¿No tienes cuenta? <asp:HyperLink ID="lnkRegistroTienda" runat="server" CssClass="text-primary fw-semibold text-decoration-none">Regístrate aquí</asp:HyperLink></p>
                </asp:Panel>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="position-relative d-flex gap-2">
                        <span class="material-symbols-outlined position-absolute home-search-icon text-muted">search</span>
                        <asp:TextBox ID="txtBusqueda" runat="server" CssClass="form-control home-search-input rounded-3 border-1" placeholder="¿Qué estás buscando? Ej: iPhone 13 Pro" />
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click" />
                    </div>
                </div>
            </div>
        </section>

        <!-- Chips Section -->
        <section class="mb-5">
            <div class="d-flex flex-wrap justify-content-center align-items-center gap-3">
                <div class="d-inline-flex align-items-center">
                    <label for="<%= ddlCategoria.ClientID %>" class="me-2 fw-semibold">Categorías:</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" 
                        CssClass="form-select category-chip" 
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="ddlCategoria_SelectedIndexChanged"
                        EnableViewState="true"
                        Style="min-width: 200px;">
                    </asp:DropDownList>
                </div>
            </div>
        </section>

        <!-- Resultados de búsqueda -->
        <asp:Panel ID="pnlResultados" runat="server" Visible="true">
            <section class="mb-4">
                <h3 class="h2 fw-bold mb-3">Resultados</h3>
                <asp:Literal ID="litResumen" runat="server" />
                <div class="row g-4 mt-2">
                    <asp:Repeater ID="rptResultados" runat="server">
                        <ItemTemplate>
                            <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                                <div class="card product-card h-100 border-0 shadow-sm">
                                    <div class="position-relative overflow-hidden">
                                        <img src='<%# 
    (Eval("Imagenes") != null && ((List<Dominio.Imagen>)Eval("Imagenes")).Count > 0)
        ? ResolveUrl(((List<Dominio.Imagen>)Eval("Imagenes"))[0].RutaImagen)
        : "https://via.placeholder.com/600x600?text=Sin+Imagen" 
%>'
                                            alt='<%# Eval("Nombre") %>'
                                            class="card-img-top product-image" />
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
                <!-- Paginación -->
                <asp:Panel ID="pnlPaginacion" runat="server" Visible="false" CssClass="mt-4">
                    <nav aria-label="Paginación de resultados">
                        <ul class="pagination justify-content-center">
                            <asp:Repeater ID="rptPaginacion" runat="server">
                                <ItemTemplate>
                                    <li class='page-item <%# Eval("EsActiva").ToString() == "True" ? "active" : "" %>'>
                                        <asp:LinkButton ID="lnkPagina" runat="server" 
                                            CssClass="page-link" 
                                            CommandArgument='<%# Eval("NumeroPagina") %>'
                                            OnClick="lnkPagina_Click">
                                            <%# Eval("NumeroPagina") %>
                                        </asp:LinkButton>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </nav>
                </asp:Panel>
            </section>
        </asp:Panel>

        <!-- Te puede Interesar -->
        <section class="mb-4">
            <h3 class="h2 fw-bold mb-4">Te puede Interesar</h3>
            <div class="row g-4">
                <asp:Repeater ID="rptTePuedeInteresar" runat="server">
                    <ItemTemplate>
                        <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <div class="position-relative overflow-hidden">
                                    <img src='<%# 
    (Eval("Imagenes") != null && ((List<Dominio.Imagen>)Eval("Imagenes")).Count > 0)
        ? ResolveUrl(((List<Dominio.Imagen>)Eval("Imagenes"))[0].RutaImagen)
        : "https://via.placeholder.com/600x600?text=Sin+Imagen" 
%>'
                                        alt='<%# Eval("Nombre") %>'
                                        class="card-img-top product-image" />
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
        </section>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            var ddlCategoria = document.getElementById('<%= ddlCategoria.ClientID %>');
            if (ddlCategoria) {
                ddlCategoria.style.color = '#212529';
                ddlCategoria.style.backgroundColor = 'white';
                
                if (ddlCategoria.selectedIndex >= 0) {
                    var selectedText = ddlCategoria.options[ddlCategoria.selectedIndex].text;
                }
            }
        });

        if (typeof Sys !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                var ddlCategoria = document.getElementById('<%= ddlCategoria.ClientID %>');
                if (ddlCategoria) {
                    ddlCategoria.style.color = '#212529';
                    ddlCategoria.style.backgroundColor = 'white';
                }
            });
        }
    </script>
</asp:Content>
