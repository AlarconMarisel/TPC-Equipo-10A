<%@ Page Title="Detalle del Producto" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DetalleArticulo.aspx.cs" Inherits="APP_Web_Equipo10A.DetalleArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-gallery-main {
            aspect-ratio: 1/1;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: 80%;
            margin: 0 auto;
        }
        .product-gallery-thumb {
            aspect-ratio: 1/1;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 2px solid transparent;
            width: 90%;
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
            font-size: 3rem;
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
        .related-item-image {
            aspect-ratio: 4/5;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            border-radius: 8px;
            width: 85%;
            margin: 0 auto;
        }
        .carousel-container {
            overflow-x: auto;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        .carousel-container::-webkit-scrollbar {
            display: none;
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
                <span class="breadcrumb-item">/</span>
                <a href="#" class="breadcrumb-item text-decoration-none">Ropa</a>
                <span class="breadcrumb-item">/</span>
                <span class="breadcrumb-item">Chaquetas</span>
            </div>
        </nav>

        <div class="row g-4 g-lg-5">
            <!-- Image Gallery -->
            <div class="col-lg-6">
                <div class="d-flex flex-column gap-3">
                    <!-- Main Image -->
                    <div class="product-gallery-main" 
                         id="mainImage" 
                         style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBOBvPZ4HENj4hDL8Q4MYHPGmtjrr8cpO8r6RpqAdv_Pjxc9TN6ORj0V_36rque8xqmkf2UATGTxGOncZ8917CJOa2rAe0hApEgBFjEmYyYV34jqzcZzwbJpu2EwEVTm6EJAUZlaDQlch7lrcjwaDMLM58VcOJjLY4bpfi8FPO5vXMkN0jhNAcxBQ2Hdu2RIM6G7uDLlYPPmanj3q1WC9WToLvfCXkqwHFO-lIXLDgidYnRG0uvYw0tAduIodqypiDpByjUJR8GG-0');">
                    </div>
                    
                    <!-- Thumbnail Gallery -->
                    <div class="row g-2">
                        <div class="col">
                            <div class="product-gallery-thumb active" 
                                 data-image="https://lh3.googleusercontent.com/aida-public/AB6AXuBOBvPZ4HENj4hDL8Q4MYHPGmtjrr8cpO8r6RpqAdv_Pjxc9TN6ORj0V_36rque8xqmkf2UATGTxGOncZ8917CJOa2rAe0hApEgBFjEmYyYV34jqzcZzwbJpu2EwEVTm6EJAUZlaDQlch7lrcjwaDMLM58VcOJjLY4bpfi8FPO5vXMkN0jhNAcxBQ2Hdu2RIM6G7uDLlYPPmanj3q1WC9WToLvfCXkqwHFO-lIXLDgidYnRG0uvYw0tAduIodqypiDpByjUJR8GG-0"
                                 style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBOBvPZ4HENj4hDL8Q4MYHPGmtjrr8cpO8r6RpqAdv_Pjxc9TN6ORj0V_36rque8xqmkf2UATGTxGOncZ8917CJOa2rAe0hApEgBFjEmYyYV34jqzcZzwbJpu2EwEVTm6EJAUZlaDQlch7lrcjwaDMLM58VcOJjLY4bpfi8FPO5vXMkN0jhNAcxBQ2Hdu2RIM6G7uDLlYPPmanj3q1WC9WToLvfCXkqwHFO-lIXLDgidYnRG0uvYw0tAduIodqypiDpByjUJR8GG-0');">
                            </div>
                        </div>
                        <div class="col">
                            <div class="product-gallery-thumb" 
                                 data-image="https://lh3.googleusercontent.com/aida-public/AB6AXuCwTDI_SdzEq4u7g6s9PXtrlmPOb-xXYX-Q89HRZ7CXcVR_V-ggn9KjRLwaL7Twv-ddVwgYaAso1tggb0ikaywJqNyxdXxoZ0MV8janzR6OTC3eiZxSdRHcC-GEwUOGVrI03m9_VLozgCpTFgVbYq4vjMF-GsCPvPGT-IyaTxLFLjCPQ-_wk96cGNv-ZGZVUtVeCZY8aGDTiz-IKuWGc1T7yGwkwElVW2tbCCN6sL3HF0ds6ZIsn70Rd0Pu0Ool0iOjy3R64xlOEWk"
                                 style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCwTDI_SdzEq4u7g6s9PXtrlmPOb-xXYX-Q89HRZ7CXcVR_V-ggn9KjRLwaL7Twv-ddVwgYaAso1tggb0ikaywJqNyxdXxoZ0MV8janzR6OTC3eiZxSdRHcC-GEwUOGVrI03m9_VLozgCpTFgVbYq4vjMF-GsCPvPGT-IyaTxLFLjCPQ-_wk96cGNv-ZGZVUtVeCZY8aGDTiz-IKuWGc1T7yGwkwElVW2tbCCN6sL3HF0ds6ZIsn70Rd0Pu0Ool0iOjy3R64xlOEWk');">
                            </div>
                        </div>
                        <div class="col">
                            <div class="product-gallery-thumb" 
                                 data-image="https://lh3.googleusercontent.com/aida-public/AB6AXuBzGX8zPCHlZbAk5WldJvLM3nmR74kR_YAhfOJsuvMCnvwIB312dLR8w2Xh1Lvbh7d40K7hPZN4qRXjh68rfXECQVNuLgidoYTQl9wO_EZeKbvOzzckTmFpdJ1ByA6rqGwPfnMMucBfz_77zp8gTV3V8AZKFoUspE4PUsfZVH2n8I9AsUwo1Iwp9OHQuZCT0ccD5UoNdNW19uZaLCZuXGLGpqzd8OOHBB2ag8voYAbpC84dhTt_aJIA0ocrNsTOUdE7h-e6oTbH2-0"
                                 style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBzGX8zPCHlZbAk5WldJvLM3nmR74kR_YAhfOJsuvMCnvwIB312dLR8w2Xh1Lvbh7d40K7hPZN4qRXjh68rfXECQVNuLgidoYTQl9wO_EZeKbvOzzckTmFpdJ1ByA6rqGwPfnMMucBfz_77zp8gTV3V8AZKFoUspE4PUsfZVH2n8I9AsUwo1Iwp9OHQuZCT0ccD5UoNdNW19uZaLCZuXGLGpqzd8OOHBB2ag8voYAbpC84dhTt_aJIA0ocrNsTOUdE7h-e6oTbH2-0');">
                            </div>
                        </div>
                        <div class="col">
                            <div class="product-gallery-thumb" 
                                 data-image="https://lh3.googleusercontent.com/aida-public/AB6AXuDmyZ6mXdNhNIOlEI49igegYA1L4F2Y-ZYBabvzmx2FSPHTG4j-gApHMybMYWwkYjoJLa8iPcFWX0fVLVPzC_Zow9_B_XhGXNWL6Zs96UgTirZ_eY2-mrujLP8G8Tytrod95Pt_U4x4QA8MMHnaiYhigQ6dftQcPORAy1hnXm4Zb_h9fmFDIPSaSUgZSe_7r6ip68iM_0--ppJVbMMdoY0ijQXOlhYaX6yn61Z2rRoEbHWWB-5kyN65TTugYwH-wcQOdY9mH9wjXus"
                                 style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDmyZ6mXdNhNIOlEI49igegYA1L4F2Y-ZYBabvzmx2FSPHTG4j-gApHMybMYWwkYjoJLa8iPcFWX0fVLVPzC_Zow9_B_XhGXNWL6Zs96UgTirZ_eY2-mrujLP8G8Tytrod95Pt_U4x4QA8MMHnaiYhigQ6dftQcPORAy1hnXm4Zb_h9fmFDIPSaSUgZSe_7r6ip68iM_0--ppJVbMMdoY0ijQXOlhYaX6yn61Z2rRoEbHWWB-5kyN65TTugYwH-wcQOdY9mH9wjXus');">
                            </div>
                        </div>
                        <div class="col">
                            <div class="product-gallery-thumb" 
                                 data-image="https://lh3.googleusercontent.com/aida-public/AB6AXuC8DFA8yhT59EeV4ouGweJqkfJKY7rTr_lrlo6bFynA5Yqn1TDRH3skpvsuSxIYLOZgFKablwBVgCJ5QSLygh6qfvAX00PhCaKGqX8q2k4iEPgiGgJ3tVkitf6iVn-yL66015mxcFsabB_IgJIuj4SxO_k9zq_hIRalsseEwOkjjn_B859Xrte77cJgUvDawfTMzUToaX0JSkxDuaYBX1V8fyqvsU--g6THuiqayl2fFM3xph7U4YzZUlUTOxOk92N6YmV4PcBv22Q"
                                 style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC8DFA8yhT59EeV4ouGweJqkfJKY7rTr_lrlo6bFynA5Yqn1TDRH3skpvsuSxIYLOZgFKablwBVgCJ5QSLygh6qfvAX00PhCaKGqX8q2k4iEPgiGgJ3tVkitf6iVn-yL66015mxcFsabB_IgJIuj4SxO_k9zq_hIRalsseEwOkjjn_B859Xrte77cJgUvDawfTMzUToaX0JSkxDuaYBX1V8fyqvsU--g6THuiqayl2fFM3xph7U4YzZUlUTOxOk92N6YmV4PcBv22Q');">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="col-lg-6">
                <div class="d-flex flex-column h-100 py-4">
                    <!-- Product Title and Badge -->
                    <div class="d-flex flex-wrap justify-content-between gap-3 mb-3">
                        <div class="d-flex flex-column gap-2">
                            <h1 class="product-title text-dark mb-0">Chaqueta de Cuero Vintage</h1>
                            <p class="unique-badge mb-0">¡Única unidad disponible!</p>
                        </div>
                    </div>

                    <!-- Price -->
                    <p class="product-price text-dark mb-4">$45.00</p>

                    <!-- Description -->
                    <div class="product-description mb-4">
                        <p class="mb-3">Auténtica chaqueta de cuero de los años 80, en excelente estado de conservación. Ideal para un look retro y atemporal. Piel genuina, suave al tacto y con un forro interior cálido.</p>
                        <p class="d-none d-md-block mb-3">Presenta ligeras marcas de uso que le confieren un carácter único, sin roturas ni desperfectos mayores. Todos los cierres y botones son originales y funcionan perfectamente. Talla M de hombre.</p>
                        <a href="#" class="text-primary fw-semibold text-decoration-none">Leer más...</a>
                    </div>

                    <!-- CTA Button -->
                    <div class="mt-auto pt-4">
                        <a href="CarritoReserva.aspx" class="btn btn-primary cta-button w-100 w-md-auto d-flex align-items-center justify-content-center gap-2 text-decoration-none">
                            <span class="material-symbols-outlined">add_shopping_cart</span>
                            <span>Agregar al Carrito de Reserva</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Separator -->
        <div class="separator"></div>

        <!-- Related Items -->
        <div>
            <h2 class="h2 fw-bold text-dark mb-4">También te podría interesar</h2>
            
            <!-- Carousel -->
            <div class="carousel-container">
                <div class="d-flex gap-4 px-0">
                    <!-- Related Item 1 -->
                    <div class="related-item">
                        <div class="related-item-image mb-3" 
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuClb3G2pC2pjfAMA_r6ZEXsdLMWnZg86DsYwpRrWDskycP2WpsC_ECNEutXACQ2GFc65JrrlUrOznQk5ak224JRptUOQ2DEpD8YLl3y_Oh4WsCpH56TDh9dHsubadM1UuTKQFhtgbktaxzZGRf4UtZgVkFNkTQdDjUTClBhmruIrckY_39Mk7rUqQ3vm1D13hVaaU83wTb2s7tViTy2x8H87LpsDEnY5egx0opj5kst8OgDMVmuNBN6xkhPOQiOJsbkZnMm93GgVJY');">
                        </div>
                        <div class="d-flex flex-column">
                            <p class="text-dark fw-medium mb-1">Vaqueros Clásicos</p>
                            <p class="text-dark fw-bold h5 mb-0">$25.00</p>
                        </div>
                    </div>

                    <!-- Related Item 2 -->
                    <div class="related-item">
                        <div class="related-item-image mb-3" 
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAsBjolgv7GduH6lN_4fNESs66xYP9zMGYjP0xhASwyWWs9wzFFFWRRG0BbAT34Iqr1OoNPtA8Y0tECKgJ9L3eC0kInH-_uKmu1kj53AenfVKzXj86r2-37A-2pnuipuCdwHWOLYTfacQ3PrUrgnJw4uvVpeTqS8C6dNU9oFiTHJ99nQExnRYjHZEt39FTLz9Y14Gi4VK1msvTob7TEApWRfcYuH9OBn2hpzYHd-4ISQG8SxSE6QlDW3wsXzG6Gk37LFxbBFDbyuOI');">
                        </div>
                        <div class="d-flex flex-column">
                            <p class="text-dark fw-medium mb-1">Botas de Cuero</p>
                            <p class="text-dark fw-bold h5 mb-0">$60.00</p>
                        </div>
                    </div>

                    <!-- Related Item 3 -->
                    <div class="related-item">
                        <div class="related-item-image mb-3" 
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAoOtnBM2KmYs1X4S0oEnX8gu5WTaYvbTDvlLZezFtGCrDMs53eJjqgTBsewfri5nNd8kHs0a_E17JfLbTNh02kJoQpw3kX2MyvsFrMqhh2I-s-KovrzPeZEYZHiaSVzAmUmzARdZGfidWsSc1Cn5GWj1th8IUmcKBK2rnSdQ7axKmqeREQ6N4jOW50Rwm6YlbDv-tV4_uGE2WRPKrBxxX9d7MHr4CfFHn105sfwrBLvvPd_yzA_a1Ds11BUa7LJEAAqjvmkmW5buQ');">
                        </div>
                        <div class="d-flex flex-column">
                            <p class="text-dark fw-medium mb-1">Gafas de Sol Aviador</p>
                            <p class="text-dark fw-bold h5 mb-0">$15.00</p>
                        </div>
                    </div>

                    <!-- Related Item 4 -->
                    <div class="related-item">
                        <div class="related-item-image mb-3" 
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBVZN1ccYAX6JYIS1a499KQnl2BYfQUmjMlluQw5uFxeAZjDxCM3vWv1MgEBIgGz93NLkie3TeWwyO_xh2tLuH5LtLKAuiiIxUaGzyiXrkSLAOW3ljnLhGeUpWIrxOnBVghefvxuinIdUQjD8kWF4yGJZMl8xw2Dk06ktTFF7STlfb1xHhSp6yNveVZHs5BaKuHxjj-eG6S34A9mKZByQoyCOXePGDafDresAFrbdrKlguDptaXywQEd4TAH1vbFkUI47HU4L_CHvU');">
                        </div>
                        <div class="d-flex flex-column">
                            <p class="text-dark fw-medium mb-1">Reloj de Pulsera Clásico</p>
                            <p class="text-dark fw-bold h5 mb-0">$35.00</p>
                        </div>
                    </div>

                    <!-- Related Item 5 -->
                    <div class="related-item">
                        <div class="related-item-image mb-3" 
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCgWcwpk0gipseKt86HDf2do45898cJsc1glzsJB47DO4s6ChA7_JnnFCAp1U3ItnCXorPwC2k6mfUnD9al1uTs3WlXiCy330rJPBMIvQHRDrawZC0m5e-iOZBCOEALz5Q9oI_iA19-MKnZDm9CJZaCQxKJAFX_L8pcqXu74K-s7Urw-Y-rX95yKNrywbDoJAnpTabKGylxPrjaPqvihFkKkkiQVsscQR3LsAUs8jpHU2I4kqmzTGz10aWGib-QP7kduBS3E26V1pg');">
                        </div>
                        <div class="d-flex flex-column">
                            <p class="text-dark fw-medium mb-1">Cinturón de Piel</p>
                            <p class="text-dark fw-bold h5 mb-0">$12.00</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    
</asp:Content>
