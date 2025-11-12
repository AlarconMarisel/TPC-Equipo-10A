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
        }

            .category-chip:hover {
                border-color: #0d6efd !important;
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
            aspect-ratio: 1/1;
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            background-color: #f8fafc;
            border-radius: 12px;
        }

        .product-card:hover .product-image {
            transform: scale(1.05);
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
                <div class="dropdown">
                    <button class="btn btn-outline-secondary category-chip d-inline-flex align-items-center justify-content-center px-3 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="fw-semibold">Categorías</span>
                    </button>

                    <ul class="dropdown-menu shadow-sm p-2">
                        <li><a class="dropdown-item" href="#">Electrónica</a></li>
                        <li><a class="dropdown-item" href="#">Ropa</a></li>
                        <li><a class="dropdown-item" href="#">Muebles</a></li>
                        <li><a class="dropdown-item" href="#">Libros</a></li>
                        <li><a class="dropdown-item" href="#">Deportes</a></li>
                        <li><a class="dropdown-item" href="#">Hogar y Jardín</a></li>
                    </ul>
                </div>
                <button class="btn btn-outline-secondary category-chip">
                    <span class="fw-medium">Electrónica</span>
                </button>
                <button class="btn btn-outline-secondary category-chip">
                    <span class="fw-medium">Ropa</span>
                </button>
                <button class="btn btn-outline-secondary category-chip">
                    <span class="fw-medium">Muebles</span>
                </button>
                <button class="btn btn-outline-secondary category-chip">
                    <span class="fw-medium">Libros</span>
                </button>
            </div>
        </section>

       <!-- Resultados de búsqueda -->
<asp:Panel ID="pnlResultados" runat="server" Visible="false">
    <section class="mb-4">
        <h3 class="h2 fw-bold mb-3">Resultados</h3>
        <asp:Literal ID="litResumen" runat="server" />
        <div class="row g-3 mt-2">
            <asp:Repeater ID="rptResultados" runat="server">
                <ItemTemplate>
                    <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                        <div class="card product-card h-100 border-0 shadow-sm">
                            <div class="position-relative overflow-hidden">
                                <img src="<%# !string.IsNullOrEmpty((Eval("Imagenes[0].RutaImagen") ?? "").ToString()) ? ResolveUrl(Eval("Imagenes[0].RutaImagen").ToString()) : "https://via.placeholder.com/600x600?text=Sin+Imagen" %>"
                                     alt="<%# Eval("Nombre") %>"
                                     class="card-img-top product-image" />
                            </div>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title fw-semibold"><%# Eval("Nombre") %></h5>
                                <p class="text-muted small mb-2"><%# Eval("Descripcion") %></p>
                                <p class="text-muted mb-1">Categoría: <%# Eval("CategoriaArticulo.Nombre") %></p>
                                <p class="text-muted">Estado: <%# Eval("EstadoArticulo.Nombre") %></p>
                                <p class="card-text h4 fw-bold text-primary mb-3">
                                    $<%# string.Format("{0:N0}", Eval("Precio")) %>
                                </p>

                                <!-- 🔗 Botón Ver Artículo -->
                                <a href='DetalleArticulo.aspx?id=<%# Eval("IdArticulo") %>'
                                   class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>
</asp:Panel>


        <!-- Section Header & Product Grid (contenido de ejemplo) -->
        <section>
            <h3 class="h2 fw-bold mb-4">Artículos Recientes</h3>
            <div class="row g-4">
                <!-- Product Card 1 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuD8SQBb4QB6TvEtdwkfTA0_pa-Fi-F7faTHI1m2JDJcVZp1rpVZF8iAMQ3MsSLBCTkm5SaW4Z_8Qg5lHSWYO3CW_TkV1V1PhpkYn8dWps7eFXCKN8Bg8zT76Wb3JR55gEPnuzbxhQzh03GiZRk92q0nh9etb0ffqDl17M3V91wnsrcKwSfWJo51cLLaWlEWad4gctzpfiObprZ6Ha2pzE2i7kzfjXWK--KkfKOItBCmIf8Y8Xs21NI3sUABHqI_9Trserv1YgE9byk"
                                alt="Silla de oficina ergonómica de color negro con reposabrazos."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Silla de Oficina Ergonómica</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$85.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 2 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuC5O4ssbYoLwu7J_XcHZH0shscSkunpK21EiAYk02WoPU1jDTnCBUm3OIL_rYD-gAnDPrI_Q8MSbu7Ull3_iKZrhrue6QPl5bYq8N27ipZobxilgIGvhKQdY3Znn55ZD9TEp6UgQ8zp4wz9RBcbbBCFyW3VGCEhD5CufOERWp-mo7d4jo_2V8UF8bJqiVSR9YoUaTGHsMD57kDa1u69l2teY9b5lY3UO7ReFZO4CJrJ0LWJ1y1CQj25GYyomtAeb74n4-y63_RItoU"
                                alt="Reloj analógico clásico con correa de cuero marrón y esfera blanca."
                                class="card-img-top product-image" />
                            <span class="position-absolute top-0 end-0 m-3 popular-badge text-white">Popular</span>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Reloj Clásico de Cuero</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$120.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 3 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDEn_KAM9OSkjlhMhEU_zCQkFsqVUrd7oOY35xRvo6fm_MR-KQQ8eoXG0Rc8b0BCSMeE-vmhfAry9D5eZLfBdkZbeEnf-rg8_TH761bMeTcftZ-QPQpo5_sgTJeyO0aQp7Zms4XJxD98tqYM2sd_4_21FGEjywIImFyy_FdD0v2eAbTzQeB3HcceFdlRD0QgDK0gr4BBp6iFR2i3mBPbkDfQq2dOqfqMLvlUa1am67ep2oCmkF-UY7RGqDu_nUJGWrmOWwy-EqirSA"
                                alt="Cámara fotográfica vintage de color plateado sobre una superficie de madera."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Cámara Vintage Analógica</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$250.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 4 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAL7cfC3rVc-8E_KoN6O-CMIopemupP4VXIKDv-lqi4ElfPnLctKImJqLqb0ZKLKgXQ2-N53fia7MYYhKckyOMOzLot1EfUuLo9f7iNq5kObjNlYm1t56gEcXevvtMaMIq4L3PwR4NzrYcl-K225nsYRMrgO09S89I_cu4j46sQMeoYjCwV8oZ-QppcEeS1ushWJ8nD7vufqqmki5SjkbqoK6ge-UIMqiJh85JkxMcK27l51eozf55o--bvC9kRzD6DU2vgaomULbI"
                                alt="Auriculares inalámbricos de color blanco dentro de su estuche de carga abierto."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Auriculares Inalámbricos Pro</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$95.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 5 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDElwpgODlUjuYZ6gdVQknXWHCXjwTqK8tAVwALbN-xHxYLN0aw3rjtwqo6yItrQQsMwIfn3dqnVvNfIBfJBxKqUAVDcrcQKdPRuLWFixlnMnAOv7Hb_UaixIkJG3KhnLQw5EX0IEBWevqZMmCIvCBil0388IvI7fByzE-EP1xIT9MrUBNgpzGorAJ8GrGHT470108J_I1vYCly4syHx4kv0ZDVCrUyTKEZc5NThF-Q8cDcMbKuFc7X2GdVlpV7hHm3HNeRi6n1TjA"
                                alt="Pila de varios libros de tapa dura con diferentes colores."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Colección de Libros Clásicos</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$40.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 6 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCUArZ82xq7MOVRIKfWj79Vce3w_mgaE2352jzGBdCMTkkwxbs9r3J8ah8ft43RcgOmlThmu6XE81AhAqInVFYllY08uiwCJnahMFpR_AsVU5axJZi1KI34qqQ4S-MFXTiapFcJSWSBE45Na0UCXA1vfnopRQdXk9WXc3GxJfje1o_oNyXVDUC2VacDfJNUHZ7x-FsRKErj9nf9eFXl5owLNoF82O4KSl9qDh6wP-HaNopfLAijjNmyk5Wbf0hg5_4-rFzW6s31Quo"
                                alt="Par de zapatillas deportivas de color blanco y negro sobre un fondo liso."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Zapatillas Deportivas</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$65.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 7 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDgzP82zZnfT9MEpbOrrRQHwRbe-fY8EVoE9uM1_IqN0FVSW3f0dRiosdI2olR9-AtfSlLhaYn5gRbQJrMs9ts9gikjaHEnAcyoPaIJZxkpSeDLPBjRfNq1bjHNUKMubbs-YCuUa37LBaWgAenci77gShr-0MJBerCgIkIrddZKugPm9e9Ryj0UoDbr3CS6jZQID5jwbPDH_BcQHNFU38LsmPM76NMcXRhiaIDzwCdewdPAtD4tXTBsItpjvC7RqjUmMcB82d_-4Yc"
                                alt="Mesa de centro moderna de madera clara en una sala de estar luminosa."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Mesa de Centro Moderna</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$110.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card 8 -->
                <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <div class="position-relative overflow-hidden">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDB4WDwlbw1Yzxkottup7AqUqALm9aUM4rZOGOZWnXbmgwnDKaTwdis-cCeQyZgBa1yOSMDG0yqYRLHvR6WTBTBYwm_17UBAdNOhZfSBOCgazAO0pP9r1OcyyR-KEuChtZ70ELyWH6Z_fM0X4IN6O6eaDfkIuiBmex_kvp0Pa030UJ6BFS-OCLd6TdWOM6JSDF-F_wwCKnr1f_huB6R1repRBC7xH0-myFS5f8Pqg86HFY_yPwnO7kr2MoQzkYX4qiYLeuR4fwZ3-o"
                                alt="Portátil moderno de color plateado abierto sobre un escritorio minimalista."
                                class="card-img-top product-image" />
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-semibold">Laptop Ultra Ligera</h5>
                            <p class="card-text h4 fw-bold text-primary mb-3">$650.00</p>
                            <a href="DetalleArticulo.aspx" class="btn btn-primary w-100 fw-bold text-decoration-none">Ver Artículo</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
