<%@ Page Title="Cómo Funciona" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ComoFunciona.aspx.cs" Inherits="APP_Web_Equipo10A.ComoFunciona" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
        }
        .step-card {
            border: none;
            border-radius: 16px;
            padding: 2.5rem;
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        .step-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .step-number {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
            font-weight: bold;
            margin: 0 auto 1.5rem;
        }
        .process-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }
        .section-content {
            padding: 4rem 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-4 fw-bold mb-4">Cómo Funciona SecondHand</h1>
                    <p class="lead mb-0">Un proceso simple y seguro para comprar y vender productos de segunda mano</p>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-3">Proceso de Compra</h2>
                <div class="border-bottom border-primary border-3 mx-auto" style="width: 80px;"></div>
                <p class="text-muted mt-3">Sigue estos simples pasos para realizar tu compra</p>
            </div>

            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="step-card text-center">
                        <div class="step-number">1</div>
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">search</span>
                        </div>
                        <h4 class="fw-bold mb-3">Explora el Catálogo</h4>
                        <p class="text-muted mb-0">
                            Navega por nuestro catálogo de productos de segunda mano. Puedes buscar por nombre, descripción o filtrar por categoría para encontrar exactamente lo que buscas.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="step-card text-center">
                        <div class="step-number">2</div>
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">visibility</span>
                        </div>
                        <h4 class="fw-bold mb-3">Revisa los Detalles</h4>
                        <p class="text-muted mb-0">
                            Haz clic en cualquier producto para ver su descripción completa, precio, estado, múltiples imágenes y toda la información que necesitas para tomar tu decisión.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="step-card text-center">
                        <div class="step-number">3</div>
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">shopping_cart</span>
                        </div>
                        <h4 class="fw-bold mb-3">Agrega al Carrito</h4>
                        <p class="text-muted mb-0">
                            Selecciona los productos que deseas comprar y agrégalos a tu carrito de reserva. Puedes agregar múltiples artículos y revisar tu selección antes de confirmar.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="step-card text-center">
                        <div class="step-number">4</div>
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">payments</span>
                        </div>
                        <h4 class="fw-bold mb-3">Paga la Seña</h4>
                        <p class="text-muted mb-0">
                            Confirma tu reserva y realiza el pago de la seña (10% del valor total). Esto garantiza que el producto quede reservado para ti durante 72 horas.
                        </p>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-lg-6 mx-auto">
                    <div class="step-card text-center">
                        <div class="step-number">5</div>
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">check_circle</span>
                        </div>
                        <h4 class="fw-bold mb-3">Completa tu Compra</h4>
                        <p class="text-muted mb-0">
                            Dentro de las 72 horas siguientes, completa el pago del saldo restante (90%). Una vez confirmado el pago completo, tu compra estará finalizada y el producto será marcado como vendido.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-3">Proceso de Venta</h2>
                <div class="border-bottom border-primary border-3 mx-auto" style="width: 80px;"></div>
                <p class="text-muted mt-3">Si eres administrador, así es como puedes vender productos</p>
            </div>

            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="step-card text-center">
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">add_circle</span>
                        </div>
                        <h4 class="fw-bold mb-3">Agrega tu Producto</h4>
                        <p class="text-muted mb-0">
                            Accede al Panel de Administración y crea un nuevo artículo. Completa toda la información: nombre, descripción detallada, precio, categoría y estado del producto.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="step-card text-center">
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">image</span>
                        </div>
                        <h4 class="fw-bold mb-3">Sube las Imágenes</h4>
                        <p class="text-muted mb-0">
                            Agrega imágenes de calidad de tu producto desde diferentes ángulos. Las buenas fotografías aumentan significativamente las posibilidades de venta.
                        </p>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="step-card text-center">
                        <div class="process-icon">
                            <span class="material-symbols-outlined text-white" style="font-size: 40px;">publish</span>
                        </div>
                        <h4 class="fw-bold mb-3">Publica y Espera</h4>
                        <p class="text-muted mb-0">
                            Una vez publicado, tu producto aparecerá en el catálogo. Los compradores podrán verlo, reservarlo y realizar la compra. El sistema actualizará automáticamente el estado cuando se venda.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h3 class="fw-bold mb-4">Información Importante</h3>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-start">
                                        <span class="material-symbols-outlined text-primary me-3" style="font-size: 32px;">schedule</span>
                                        <div>
                                            <h5 class="fw-bold mb-2">Tiempo de Reserva</h5>
                                            <p class="text-muted mb-0">Las reservas tienen una validez de 72 horas. Si el comprador no completa el pago en ese tiempo, la reserva puede ser cancelada.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-start">
                                        <span class="material-symbols-outlined text-primary me-3" style="font-size: 32px;">security</span>
                                        <div>
                                            <h5 class="fw-bold mb-2">Transacciones Seguras</h5>
                                            <p class="text-muted mb-0">Todas las transacciones se registran en nuestro sistema, garantizando seguridad y trazabilidad para compradores y vendedores.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-start">
                                        <span class="material-symbols-outlined text-primary me-3" style="font-size: 32px;">info</span>
                                        <div>
                                            <h5 class="fw-bold mb-2">Estado de los Productos</h5>
                                            <p class="text-muted mb-0">Los productos pueden estar en estado Disponible, Reservado o Vendido. Solo los disponibles pueden ser agregados al carrito.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-start">
                                        <span class="material-symbols-outlined text-primary me-3" style="font-size: 32px;">support_agent</span>
                                        <div>
                                            <h5 class="fw-bold mb-2">Soporte</h5>
                                            <p class="text-muted mb-0">Si tienes dudas durante el proceso, nuestro equipo de soporte está disponible para ayudarte. Contáctanos cuando lo necesites.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-content bg-primary text-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="fw-bold mb-3">¿Listo para comenzar?</h2>
                    <p class="lead mb-4">Explora nuestro catálogo o contacta con nosotros si tienes alguna pregunta</p>
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="Default.aspx" class="btn btn-light btn-lg rounded-pill px-5">Ver Catálogo</a>
                        <a href="Contacto.aspx" class="btn btn-outline-light btn-lg rounded-pill px-5">Contactar</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

