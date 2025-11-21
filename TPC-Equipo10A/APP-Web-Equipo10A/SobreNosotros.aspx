<%@ Page Title="Sobre Nosotros" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="SobreNosotros.aspx.cs" Inherits="APP_Web_Equipo10A.SobreNosotros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
        }
        .section-content {
            padding: 3rem 0;
        }
        .feature-icon {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        .value-card {
            border: none;
            border-radius: 12px;
            padding: 2rem;
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .value-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-4 fw-bold mb-4">Sobre SecondHand</h1>
                    <p class="lead mb-0">Tu plataforma de confianza para comprar y vender productos de segunda mano</p>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="text-center mb-5">
                        <h2 class="fw-bold mb-3">Nuestra Historia</h2>
                        <div class="border-bottom border-primary border-3 mx-auto" style="width: 80px;"></div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 mb-4">
                            <p class="text-muted lead">
                                SecondHand nació con la visión de crear un mercado accesible y sostenible donde las personas puedan dar una segunda vida a sus productos, 
                                mientras encuentran artículos de calidad a precios justos.
                            </p>
                            <p class="text-muted">
                                En un mundo cada vez más consciente del impacto ambiental, creemos que la reutilización de productos es clave para construir un futuro más sostenible. 
                                Nuestra plataforma facilita este proceso, conectando a compradores y vendedores de manera segura y eficiente.
                            </p>
                        </div>
                        <div class="col-lg-6 mb-4">
                            <p class="text-muted">
                                Desde nuestros inicios, nos hemos comprometido a ofrecer una experiencia de usuario excepcional, con un sistema de reservas que garantiza 
                                transacciones seguras y un proceso de compra simplificado.
                            </p>
                            <p class="text-muted">
                                Trabajamos constantemente para mejorar nuestra plataforma, agregando nuevas funcionalidades y mejorando la experiencia tanto para vendedores 
                                como para compradores, siempre con el objetivo de promover la economía circular y el consumo responsable.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content bg-light">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="card value-card h-100">
                        <div class="feature-icon mx-auto">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">flag</span>
                        </div>
                        <h3 class="fw-bold text-center mb-3">Nuestra Misión</h3>
                        <p class="text-muted text-center">
                            Facilitar el acceso a productos de calidad a precios accesibles, promoviendo la economía circular y el consumo responsable, 
                            mientras creamos una comunidad de usuarios comprometidos con la sostenibilidad y el cuidado del medio ambiente.
                        </p>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card value-card h-100">
                        <div class="feature-icon mx-auto">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">visibility</span>
                        </div>
                        <h3 class="fw-bold text-center mb-3">Nuestra Visión</h3>
                        <p class="text-muted text-center">
                            Ser la plataforma líder en compra y venta de productos de segunda mano, reconocida por nuestra innovación, 
                            confiabilidad y compromiso con la sostenibilidad, transformando la forma en que las personas consumen y reutilizan productos.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-3">Nuestros Valores</h2>
                <div class="border-bottom border-primary border-3 mx-auto" style="width: 80px;"></div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="feature-icon mx-auto">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">verified</span>
                        </div>
                        <h4 class="fw-bold mt-3 mb-3">Confianza</h4>
                        <p class="text-muted">
                            Construimos relaciones basadas en la transparencia y la honestidad, garantizando transacciones seguras para todos nuestros usuarios.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="feature-icon mx-auto">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">eco</span>
                        </div>
                        <h4 class="fw-bold mt-3 mb-3">Sostenibilidad</h4>
                        <p class="text-muted">
                            Promovemos la economía circular y el consumo responsable, contribuyendo activamente a la reducción de residuos y el cuidado del planeta.
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="feature-icon mx-auto">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">groups</span>
                        </div>
                        <h4 class="fw-bold mt-3 mb-3">Comunidad</h4>
                        <p class="text-muted">
                            Fomentamos una comunidad inclusiva donde todos pueden participar, compartir y beneficiarse de la compra y venta de segunda mano.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="section-content bg-primary text-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="fw-bold mb-3">¿Listo para unirte a SecondHand?</h2>
                    <p class="lead mb-4">Comienza a comprar y vender productos de segunda mano hoy mismo</p>
                    <a href="Default.aspx" class="btn btn-light btn-lg rounded-pill px-5">Explorar Productos</a>
                </div>
            </div>
        </div>
    </section>
</asp:Content>


